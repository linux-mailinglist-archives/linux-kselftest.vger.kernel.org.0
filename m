Return-Path: <linux-kselftest+bounces-15386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6029952A56
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A827B20CA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157C19D894;
	Thu, 15 Aug 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjOA6EM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E917623F;
	Thu, 15 Aug 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708808; cv=none; b=ApQH2ZIpha0EQiz+2Wosg9uKPecMsQcj84iBC8JBCj9r4EzYCviBNvM12RDU43FPFzqmZhs5oEfl9dbpKqn2O0FBodcRG7Q85guoe6MiY9L+3imnAIOQafek7e6HdPdA4XtBw0NMKLK5SVpErazHWqgX2RIwx+w6Nlu40HXPWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708808; c=relaxed/simple;
	bh=sjiHpCBHIf9pnFhbHWS2Sj3yG1XcqLY6ol8qFa/4aKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeKqj0/NdRU/OfS9ITOQeDp4DxfHLYN/xubbfwiWG1Q3ubgNskXaGttYp+JHr5FjbQOTcT//W8dJLtgLwRCy4VhIBHzuf1seDuI7J7/C/nVnIRWkPxLD21BeptXOMSaQupLuzpmW9uRO8BTTz3vRk5EvSun4rALMexWjnh8/JsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjOA6EM0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd66cddd4dso6687875ad.2;
        Thu, 15 Aug 2024 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723708806; x=1724313606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRc6Z27GboWhsVbvaDnEpOXu5vP5on3z8eM/ZJ12F0k=;
        b=IjOA6EM04nWPI/lYElPuAXbQCzDEB93+BOMpCLEmvTSt795P9a6kqJpN1vplTnAI92
         d+z2MEyfh3BNOYfp5zEwrXM+WtxFSW0gQtEODl29QKkdRQpAKbSTouzYNDcHx9DIi90q
         ipg5Lv4lIayuHe2QBKCOBIQiPUNTqcwgF8YSNRj/jWB1MxKBsfTr9uDY7pdFIjPpqwrF
         xe/A7WiKxEXzZ9PRlWb8wKVW3u7GgXPea0OUCL6cH7fMdkH+XazovTbknkApjTiBHKFZ
         350nGU5MMoO54dU5xMAL6I0HOn4Xu+DMPuCCfnQdn40O59W/eWLhmoR97LNabbPvHq0F
         I91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723708806; x=1724313606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRc6Z27GboWhsVbvaDnEpOXu5vP5on3z8eM/ZJ12F0k=;
        b=e3YhT8v9W1OWrdavMYS3nzvFZngloNbJmjITx14OAaeSsCrE1LGu1qtkRIsA/3XPww
         zPrjnWVUFt4INOhxE0Nk+rFxZ7c67iHanUtcxULpQpO4wxcjOwG3+UJOTDlhXnPnSOud
         M6Omi/Hw0UQLR8wmlHWbtzAflq4PSyUHQQaJxJZNst+BESKOZMx4hiPqrBovFtlWp28l
         LZ5WjQLoEw3jEjtCIhcgtJBVL1uFZ3JHo9B9voLL/byDbuoKWmT/exfd6L8qSR4ruSoD
         162N9iNkNrZXpxFqWH/QihYQcFPlSS+nSSbXlcP+ar1/B07Tk1l8tFYgD6EN4jree78h
         qI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv/+4ZyWD48echdUWF3lB5a7/cRndqNocKoKsUabtEXBzR2W4DXwe98v3gMUaRnj8lar6sTI9RE71p7aTaJKTKIJ/bb25B9RU3ItAslvHwUmnNMwhouVVn5/ZaE83oYEXU3lwn
X-Gm-Message-State: AOJu0YyuXVrMfp3fWfyp3UG64nKt7/6B8hAxVf+O7gaC7I9II4gs4wAv
	xwycpD0iEagpa12OYXG3vNnLytnExF7xLX7+fgEDnLRUEA0S97LHIwaMIm0J
X-Google-Smtp-Source: AGHT+IHGxmJfm9Gfrng1BseZ3veDUjzKwZuKPmiAAFSljZy55IpqearGNpL62cDhxz39NjxMTbTJLw==
X-Received: by 2002:a17:902:d2c4:b0:1ff:393d:5e56 with SMTP id d9443c01a7336-201d63dc216mr66544835ad.36.1723708806159;
        Thu, 15 Aug 2024 01:00:06 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm6250515ad.124.2024.08.15.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:00:05 -0700 (PDT)
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
Subject: [PATCHv2 net 0/2] selftests: Fix udpgro failures
Date: Thu, 15 Aug 2024 15:59:49 +0800
Message-ID: <20240815075951.189059-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 tools/testing/selftests/net/udpgro.sh | 53 ++++++++++++++-------------
 1 file changed, 28 insertions(+), 25 deletions(-)

-- 
2.45.0


