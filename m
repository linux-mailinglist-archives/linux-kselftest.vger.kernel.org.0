Return-Path: <linux-kselftest+bounces-47121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F61CA8970
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24EB312703E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97BD347BD3;
	Fri,  5 Dec 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcc/leu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61A3242C2
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954753; cv=none; b=HJZOBPqU4fsMHohNfdc46OsIbOFJAAPJBN6745qr3u7O1H0qpyTSzpmt/msOwRAUyycw54+v7H+aLb9nO0ZGmWyDhZ3mliRKau7zRas7IckJ4ARBD4OJHeSuUihNbY16ihpD+y+EGT/XJIgdDYCuJ88/ooaTmK/fOJ+VYFfqMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954753; c=relaxed/simple;
	bh=do1Bg/NFLX33ofPgfO966WaBXgkhnoSqIQc8ImWQeBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0YbqXkbE/9TOvm7Q4ShB42tyWwJ9RngweYVKn4pCsaG4mwmuRRZZpLjR8vtsWb9tc9rmsGNKEPt79AeT6AoUgXAUszLldciIjavHo3qSSNzJ+ljL0rOyZqyrmovtw0hXWqIgcZudbjsNkjcjJxD3vabdeWhFu53xWSADqGg7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcc/leu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so2185220b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954741; x=1765559541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=JJcc/leubWpbR6RaFOVl0RXLRBCSczZylWdedplWoRQG8mdVWZ+zJQjfODMK291mvj
         t3pUpRf5u9YyPcJFXg2udcz7N/H5mfJ1h9/mMDnJN5VdKXV+E6dWEp5oIh4n8cvkmxdw
         tAKxsG9OdWEsRZAgjfhQCnAg3i0e6iit9eFbVTzOSkplGDEpNwbwCGSyrAjuFesV65Th
         HLFfOChvCg4B7wUs/2uq009bbRBd+Y61OW4F/q5uOXROne/qYlj3uwxTQYxLSPxa7MS+
         JCSeQCffGWKsEA9leDcJ89AtI9JpHWpxWELnyAwV6L8J9GuvftacqM8bTC0UoAtvardk
         UXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954741; x=1765559541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=Q03GPRSUNJq2pKwIwlUx3CdNlYtoPRaALdxsfkhdQE1t7OqziymP2nmTh6iI3xdrM6
         KyHstRenaOwzDWvQCIA5BfQ4pUz1fZPvV0nZbpqI4JCdLGPe6G1rDDPAq3xmpoJnP9Y2
         UHDnHVfdsQT0N/IBzaI4TD7+kDsuhHt7dJfVPHP4DMJDwPqg62C5DND54HGLuwiub9IG
         U7nR1O6lE2grb5SYEYi5T1jl4xKKE/F5IZfEZFvejEsZpn3Cl2QAhaFaA56DcyxeM5Uv
         xVpUze/c8R7a5ip+bPdZGRg8hWhjGHcJc9eVFaWYsHBGjFlHLlg4lY2A15WQV5NsnwHs
         ORWw==
X-Forwarded-Encrypted: i=1; AJvYcCXHjcFKocu4euYnoaAKiEBfJWbckc6ZeDUiJmIXMoDyDeWLwTuyayTjd6nXTbk+m+kEfG+1QRNwcjCTHZBKg5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePQn0O+A+INmRslthwdv5igNfA7DSztL8BIBUgtHj5VzRlK2o
	HT4wfLB9wYDoJgdeA7mVYo7vKoEeJPD8PHW+FPpPpgdRbMnstReXXMZQ
X-Gm-Gg: ASbGncshKT9ooARnw7XPjwvEyxPFl8kyF5K+JNXFI5QxizwPYe7GaSwnehk0Rsbt7Rm
	HXbwCMhl91qIXFuSWEM07MvZIFvUhmwwjJ19Naa83+pmBu/FXVShBNbpuyO+4DUvZJgZs90yW05
	4SHCAaLm04/SSkj2SJL4NpgfnTRZ62/uN8WvXZ+wlkEBF7uYVy35lS0gF/AhI8RC9NqhZJ7Dt6a
	4LMsCfp1Nr9u17cFGv3f7BV1kpef1jLyaShSufNwgOSPTwBW8nV7XsLpUGCUOuqYw/75fvOlRas
	L4H5Y7kMKGTt6wGYfOQP+9pJsXm0IWqHg6at+8A5sI1CwrTie8I42xz3xZRnyO71EfK5A6Kfqcb
	fAjQU1XjV9KtuaVTBlju02BaLwMqHEQw56qUqSo7f2bi7Q08nRKzTohOpRFGwwg+LARDrJQHXgb
	eFA4jHi1hrH0ZCt6zRr6q28cY=
X-Google-Smtp-Source: AGHT+IFUqGTh0jfpOherdnSNnGlDOOKwq7w7579tMDelh6u7LEtZVG3BYcM84jhxsPCvqwA1KoLyZQ==
X-Received: by 2002:a05:7022:ed08:b0:119:e56b:98a4 with SMTP id a92af1059eb24-11df6463bf3mr4137737c88.11.1764954740834;
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20699034c88.9.2025.12.05.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable warning
Date: Fri,  5 Dec 2025 09:10:02 -0800
Message-ID: <20251205171010.515236-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following warning is seen when building netlink-dumps.

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 679b6c77ace7..67bf3fc2d66b 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.45.2


