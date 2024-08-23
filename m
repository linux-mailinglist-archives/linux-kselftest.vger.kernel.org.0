Return-Path: <linux-kselftest+bounces-16176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F155895D5DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC141F230CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2341922C5;
	Fri, 23 Aug 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlwpFcoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0348F6B;
	Fri, 23 Aug 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440115; cv=none; b=hHV+6vfTbz9GO9jzN1+KRB1eKbLWCyuL3/9tLXywoMHejfC9TwqiyrLkzaurdk9d+k8BTdaUxE5dPq83YgGT+Ay9mZokLFCkMW/K4yzkVEimDwF5WYKmyGY4AKlX9AVVEPytIhP8dVZPb+HyYZntmxoO9rh9Tj7rKbc4rXuGbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440115; c=relaxed/simple;
	bh=Qxh0CtKyZd1DnK/0dchijwa1sKES+yUOrUYLIZr/5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXhB5+5Kt61p80yXqq0ZxOleLTmO13/HQW1KV4HYC8SoEWv3MDN4Ul/zIZXHdx7hjok2w394o8PbbmZ2YzUqXQtNQtNqHoBmZvwvjDQaan4kMpiR3Lz1RCOYPpaJ9NT1AGhoAGI/5TMxkoSPvuKeK0jvqRhcpzDeYArAMR+Zoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlwpFcoS; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498d7a1f734so744530137.0;
        Fri, 23 Aug 2024 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724440112; x=1725044912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QQf35c5Pp7+9zpkvOPWiJekHVDOIOVDBwe/+zf2lto=;
        b=DlwpFcoS4rQ/INZ4T7W6UY8Cc8GCr6L6eaHCHPV8qodvYWMrUdgHt0vOvJ+Ched0m8
         tPg0TXCCoJZmzjpL77iLlpPnl+X+Pne3ivXumANVMn0ysX48HSdVmiRkMC14f8uLZgwq
         lEkAhwnUhmKgGzf0Obk05+FnoEemw7J5v1PiBj9Hx/ZKdtbVPXRmVmJokVS8Z0LFx+Bx
         hMtK8qIPqq58vLohSXzhBVXvAlkKNlninWxQCT/wefr/2jkOQ0W6vv6NzY6DUSg/bSwy
         q9b5H4oaDuDVJjXsjba0gLQlvMwLM1uMf5U+WhLr8AvYp9Y0cur3ySBWIcUJcQZa7n0O
         Td7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724440112; x=1725044912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QQf35c5Pp7+9zpkvOPWiJekHVDOIOVDBwe/+zf2lto=;
        b=dKlraffE+DmQmMkr1a4puz3YCDx2x/NpVTDTzBxnkKEXcHzmoXv3HIqqYsOEldWsmP
         Dnr0j2WDUz0qaISeq+nbBhzmi/I4MPkXqO1XAZudj5VmbDa5gsEY2PZksGT3lzan3nvL
         0h0NFowiDwSibe2eu2I3s0r+9bb8YCxN6Y3Sj2tzNvo4n21VXTodYsPFTlI6HYshT2tR
         IeiD2I3t/vic2y6oAOm2xwEni99BJQxz2DgaB/rfOCLGs+oywNmBxZy43fmtj/ljjRO8
         jwf+aToO2JQW8/qD1KDzV6obQzZ9X7Q0bP4BMz1PvryumNKlphpLgKIOUp18YSS2/KsN
         xdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVq+FXYXXGo3KyyAtDJl2wMn2wI9BBMTZBFF9WkB6gAKemtZb1OBwg1bWQogP3qYj1YD5Nv4UO+utCPiYZHV/@vger.kernel.org, AJvYcCVlcM9NtFHl79A037WGEmFljAvI8A8VWeSKN2iXf0Rei8T56+BajTGDqYSZtUiZbhnf6Dxa8sKy@vger.kernel.org, AJvYcCXAxtIHxHDvaCDYmkMuxdr06roMxSb5YIRVOWIl/DWVZTRZcyH/4NweASBObNDfIRxNuXgRCqDHHeEH02I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/+xLLPeZVQLjyFsxqfLUyLAMHQWjyf1AsVRomXUPpyVD9AHn
	ztDwcJ/UhD1i+ZjjONfeplHPRnShfUJysLn0nk4REvGihkCDy6p+
X-Google-Smtp-Source: AGHT+IFjLnNiw+FcM23xAbBAxKFeWJFoyLiZ7Kzp9eZ5gVg2H+B+bqEJGz0Jks6EBCP8LNPc91nFEw==
X-Received: by 2002:a05:6102:6c9:b0:492:9ef9:9d1b with SMTP id ada2fe7eead31-498f46ea98fmr3960629137.22.1724440112406;
        Fri, 23 Aug 2024 12:08:32 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e47c5d53sm623968137.13.2024.08.23.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:08:32 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: Re: Re: [PATCH 1/1] Improve missing mods error message and make shell script executable
Date: Fri, 23 Aug 2024 15:08:28 -0400
Message-ID: <20240823190828.214443-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821180202.6da48f29@kernel.org>
References: <20240821180202.6da48f29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you say "also" there's a good chance the commit should be split into two..

I am splitting original patch into 2 separate patches. I forgot to do the reply all command on kernel lore.  Here is the link to version 2 for the improving the missing modules error message:

https://lore.kernel.org/all/20240823054833.144612-1-david.hunter.linux@gmail.com/
Subject: [PATCH 1/1 V2] Selftests: net: Improve missing modules error message

> Could you clarify how it gets skipped? We use make [...] run_tests in our CI and it does seem to run.

Here is my set up:

$ uname -a 

- Linux dshunter-HP-Laptop-15-dy5xxx 6.11.0-rc2+ #2 SMP PREEMPT_DYNAMIC Tue Aug 20 14:31:34 EDT 2024 x86_64 x86_64 x86_64 GNU/Linux

Steps I took to produce the error:
	- use git clone to get the mainline source
	- run make -C tools/testing/selftests
	- make summary=1 -C tools/testing/selftests TARGETS=net run_tests

Output: 
# selftests: net: test_ingress_egress_chaining.sh
# Warning: file test_ingress_egress_chaining.sh is not executable

After running chmod +x on the shell script. The tests were able to be run.

Thanks, 
David 

