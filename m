Return-Path: <linux-kselftest+bounces-5926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A087215A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3491F21F1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6486626;
	Tue,  5 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oiujlpEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2685927;
	Tue,  5 Mar 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648406; cv=none; b=AdHPU/r50gThCnofM/5Wvk9eYrXkNgiGpnqrs6StKQEieXqVfHCRPZklsUJ4AgB031jc8XDrRstt2cp3Wkz2upL9eR+EsYeikCc55mBogfasH1l6Xg90Q3fWOf5vqfUgCueHkGHDJzTfDqFVmZsw3PGiEu6YOZHh/J1bBMIixKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648406; c=relaxed/simple;
	bh=LjkGagwDQUYxBS8Ly5tIPDH+f57B7v3rXKFuRJpeBTM=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=gq+4EbSaX17LP87/bgUDxZV2bPsW2K2YZPtM+jKhao6Q06SeWFVFahELV2G72xk7i5SaxAXFC/T+LSy6oI+/4Seuv0XXQTDafUGQaRmJrAZlVI6lRkAioK4Nf31R4TPqHb3xCxmUX/SBr/se04SsDX7pktNgtgtQwL9wAfYpBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oiujlpEd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709648403;
	bh=LjkGagwDQUYxBS8Ly5tIPDH+f57B7v3rXKFuRJpeBTM=;
	h=Date:Cc:To:From:Subject:From;
	b=oiujlpEdKyN7b7vY1xSeM3scqEksLwiy67ChQxVTN5fiGKHkWz1LE+6h63aCcDHSH
	 Tc8Z0aCzyxyqSIe3hxuaATKJmMv/vExKML8VdOO65FNUgmVP/oKAlYjaPph1MQrzy0
	 2Wa/m7pQKdMPjlcpmuQ0MBOwbrs5361IQvXvusQ+DUsplqUZWDAALxBi7GH/aKbdf8
	 bbLqPe+4WUJ2NJUfhorq1dyl2ZqU+HwjVbJr+A5wU+sneQag+SRpfp33jcFmVUp309
	 x0MguzNvlG+VR5XaAILTYSp+VJfFmst85qpUmTMOeLJmoG9SCGMGy16XYoNNjvFFyr
	 cCKqeiDmtnhWQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2166B3780627;
	Tue,  5 Mar 2024 14:19:59 +0000 (UTC)
Message-ID: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
Date: Tue, 5 Mar 2024 19:20:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "kernel@collabora.com" <kernel@collabora.com>
Content-Language: en-US
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 Mark Brown <broonie@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [Test Failure Report] exec: Test failures in execveat
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I've been running execveat (execveat.c) locally on v6.1 and next-20240228.
It has flaky test case. There are some test cases which fail consistently.
The comment (not very clear) on top of failing cases is as following:

/*
 * Execute as a long pathname relative to "/".  If this is a script,
 * the interpreter will launch but fail to open the script because its
 * name ("/dev/fd/5/xxx....") is bigger than PATH_MAX.
 *
 * The failure code is usually 127 (POSIX: "If a command is not found,
 * the exit status shall be 127."), but some systems give 126 (POSIX:
 * "If the command name is found, but it is not an executable utility,
 * the exit status shall be 126."), so allow either.
 */
The file name is just less than PATH_MAX (4096) and we are expecting the
execveat() to fail with particular 99 or 127/128 error code. But kernel is
returning 1 error code. Snippet from full output:

# child 3493092 exited with 1 not 99 nor 99
# child 3493094 exited with 1 not 127 nor 126

I'm not sure if test is wrong or the kernel has changed the return error codes.

Full test run output:
./execveat
TAP version 13
1..51
ok 1 Check success of execveat(3, '../execveat', 0)...
ok 2 Check success of execveat(5, 'execveat', 0)...
ok 3 Check success of execveat(7, 'execveat', 0)...
ok 4 Check success of execveat(-100,
'/home/usama/repos/ke...ftests/exec/execveat', 0)...
ok 5 Check success of execveat(99,
'/home/usama/repos/ke...ftests/exec/execveat', 0)...
ok 6 Check success of execveat(9, '', 4096)...
ok 7 Check success of execveat(18, '', 4096)...
ok 8 Check success of execveat(10, '', 4096)...
ok 9 Check success of execveat(15, '', 4096)...
ok 10 Check success of execveat(15, '', 4096)...
ok 11 Check success of execveat(16, '', 4096)...
ok 12 Check failure of execveat(9, '', 0) with ENOENT
ok 13 Check failure of execveat(9, '(null)', 4096) with EFAULT
ok 14 Check success of execveat(5, 'execveat.symlink', 0)...
ok 15 Check success of execveat(7, 'execveat.symlink', 0)...
ok 16 Check success of execveat(-100,
'/home/usama/repos/ke...xec/execveat.symlink', 0)...
ok 17 Check success of execveat(11, '', 4096)...
ok 18 Check success of execveat(11, '', 4352)...
ok 19 Check failure of execveat(5, 'execveat.symlink', 256) with ELOOP
ok 20 Check failure of execveat(7, 'execveat.symlink', 256) with ELOOP
ok 21 Check failure of execveat(-100,
'/home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/execveat.symlink',
256) with ELOOP
ok 22 Check failure of execveat(5, 'pipe', 0) with EACCES
ok 23 Check success of execveat(3, '../script', 0)...
ok 24 Check success of execveat(5, 'script', 0)...
ok 25 Check success of execveat(7, 'script', 0)...
ok 26 Check success of execveat(-100,
'/home/usama/repos/ke...elftests/exec/script', 0)...
ok 27 Check success of execveat(14, '', 4096)...
ok 28 Check success of execveat(14, '', 4352)...
ok 29 Check failure of execveat(19, '', 4096) with ENOENT
ok 30 Check failure of execveat(8, 'script', 0) with ENOENT
ok 31 Check success of execveat(17, '', 4096)...
ok 32 Check success of execveat(17, '', 4096)...
ok 33 Check success of execveat(4, '../script', 0)...
ok 34 Check success of execveat(4, 'script', 0)...
ok 35 Check success of execveat(4, '../script', 0)...
ok 36 Check failure of execveat(4, 'script', 0) with ENOENT
ok 37 Check failure of execveat(5, 'execveat', 65535) with EINVAL
ok 38 Check failure of execveat(5, 'no-such-file', 0) with ENOENT
ok 39 Check failure of execveat(7, 'no-such-file', 0) with ENOENT
ok 40 Check failure of execveat(-100, 'no-such-file', 0) with ENOENT
ok 41 Check failure of execveat(5, '', 4096) with EACCES
ok 42 Check failure of execveat(5, 'Makefile', 0) with EACCES
ok 43 Check failure of execveat(12, '', 4096) with EACCES
ok 44 Check failure of execveat(13, '', 4096) with EACCES
ok 45 Check failure of execveat(99, '', 4096) with EBADF
ok 46 Check failure of execveat(99, 'execveat', 0) with EBADF
ok 47 Check failure of execveat(9, 'execveat', 0) with ENOTDIR
# Invoke copy of 'execveat' via filename of length 4094:
ok 48 Check success of execveat(20, '', 4096)...
# execveat() failed, rc=-1 errno=2 (No such file or directory)
not ok 49 Check success of execveat(6,
'home/usama/repos/ker...yyyyyyyyyyyyyyyyyyyy', 0)...
# child 3493092 exited with 1 not 99 nor 99
not ok 49 Check success of execveat(6,
'home/usama/repos/ker...yyyyyyyyyyyyyyyyyyyy', 0)...
# Invoke copy of 'script' via filename of length 4094:
ok 50 Check success of execveat(21, '', 4096)...
# execveat() failed, rc=-1 errno=2 (No such file or directory)
not ok 51 Check success of execveat(6,
'home/usama/repos/ker...yyyyyyyyyyyyyyyyyyyy', 0)...
# child 3493094 exited with 1 not 127 nor 126
not ok 51 Check success of execveat(6,
'home/usama/repos/ker...yyyyyyyyyyyyyyyyyyyy', 0)...
2 tests failed
# Totals: pass:49 fail:2 xfail:0 xpass:0 skip:0 error:0

-- 
BR,
Muhammad Usama Anjum

