Return-Path: <linux-kselftest+bounces-15297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413A9515EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E87281FFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17213C906;
	Wed, 14 Aug 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh3TiEtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89886126;
	Wed, 14 Aug 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622298; cv=none; b=t1oFtsutBy9l6uiGmqUV/k7tZKPT2TKAxNgg80mp/DrzPjjAHlOR5L6E8BrAjoGS8h72hLmj7vU40hdIpfZ60KNn0JqI8p9vX0NPmFZkBj8UrCaaOcp5TSAcza4nJCGv1p2RJ/TAI3+yL6MaEHOCVEz/wgHK2bbPbsdljWcBwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622298; c=relaxed/simple;
	bh=YnmbWsjte4BOXcRrSzwnRp5cVWo7GygJIUKhoeu2JXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYyYgqm8kpPG9KYIkGdAMwfLgxiV6rKv8be2l7SVYkMTc0tqpH+F1YML2uN1ZJE3SzyL9QvXfjUluwGBZzAue+wxw5hh+xU2yllgAVpepuV+NgnRjrJAvAG+gjfIRmRAL7HlzP8f5f4qPakWZABqE77i3oK6H4HauZTI9G8c+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh3TiEtg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fdd6d81812so63132595ad.1;
        Wed, 14 Aug 2024 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622296; x=1724227096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IdN5++kXzWrx997bDJISLJ4GNTuvxuoXHiEOMrsgcY=;
        b=Zh3TiEtgOFGuIzOym0Mas20iFA6TWS3njE7l+PCsvs5QwKvrc8KF3KJyGMlwifEbWL
         bUWLRR884WK1UXoYDIjwdgcIFPjdTRJbmZibuE8RwfH7vwOA6+ogY6Ap+bSl1mXyX3f5
         Od66B2MRh46A8uH6al4M1GQ7xn1dugfpsSs5MS5g+BzsPxNaqEInj6icX9nJsTNIqy8V
         FUW4Xc3+VjlYGEhiSeaS8JKdVfCMft08WOBXG5cqDCenQ+fKrCiNo0ZLL5Md/P2t+qlp
         I3PBFuS5yTbs8VGjrVW0ryNgdIwGUOUGoHWXwRnSAewhk+8znqv0iUzwq5ISghAtnZZH
         ny3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622296; x=1724227096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IdN5++kXzWrx997bDJISLJ4GNTuvxuoXHiEOMrsgcY=;
        b=hpDl2QaLgvRNO4cfIAL50yZFUvvYBjL6MrEogObmnyaT8ZhaV8KNXkTf8KjZol2/SN
         raZs5uVRdYrTTPzDccd6ENsrC5YiTbQYVO+N1BolnihdN/0MLjEkCic0OybkSjuzEFR8
         U2+B73tivNqWZnjsM2UJpj+3PShZLpKmfl1JF/iyUsV7Qh7krfoy50WDdWcoeehLa/cO
         moTWxgu614LBLvPrvhWua9t01lOr0aDiTu7YzcmWlG6auaeKHItp7Qrv4vpUYi5P/Buo
         ioynHREliRzKF0F2vHTJtyLOXm9ybEUVkvts5uVi0K56/zdshkl7O/f5TYKISRZkWThL
         TFrg==
X-Forwarded-Encrypted: i=1; AJvYcCVpukAFxDzNPJ5TfxucR5qEu7kWMD8c+bpmIIpq9kmV/QFX99JCtF2EJcPcqIF0s/KI0Oo=@vger.kernel.org, AJvYcCWop+5IGULEs/+bAyBxOXh/WtHSdtYV//3x6GbX/72jaT8uxSocIkOB2/qxTqbUr8i5ZIZLDMJz+2X2OkrUcI1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs8bYrjP5o+bAL3kW0EFTmrbi++ICutG29JPIfCLczpNEd3tA
	krxuRGaoiQxf0gQv69UmGek3THdKN3Hn7TCB0w4jff+f3FOXWL+YbPmayz/XYmJ1dw==
X-Google-Smtp-Source: AGHT+IEeNp/WGYGC17+9CyobXFz2KUd/hXu6ssdQln7rBTpseklUVIGhGtYnKgj/+CGq3ZEIpzNKOA==
X-Received: by 2002:a17:902:f648:b0:1f9:d0da:5b2f with SMTP id d9443c01a7336-201d6447a23mr23224295ad.39.1723622295709;
        Wed, 14 Aug 2024 00:58:15 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ba02bsm24475865ad.229.2024.08.14.00.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:58:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] selftests: Fix udpgro failures
Date: Wed, 14 Aug 2024 15:57:56 +0800
Message-ID: <20240814075758.163065-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 issues for the current udpgro test. The first one is the testing
doesn't record all the failures, which may report pass but the test actually
failed. e.g.
https://netdev-3.bots.linux.dev/vmksft-net/results/725661/45-udpgro-sh/stdout

The other one is after commit d7db7775ea2e ("net: veth: do not manipulate
GRO when using XDP"), there is no need to load xdp program to enable GRO
on veth device.

Hangbin Liu (2):
  selftests: udpgro: report error when receive failed
  selftests: udpgro: no need to load xdp for gro

 tools/testing/selftests/net/udpgro.sh | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

-- 
2.45.0


