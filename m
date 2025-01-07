Return-Path: <linux-kselftest+bounces-23982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE1A03ECF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 13:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FC73A5A09
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26B1E3DE7;
	Tue,  7 Jan 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCUqfmMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386A15665C;
	Tue,  7 Jan 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251871; cv=none; b=Mk+3qvPy2+P6wOdsRorWh4yPm5w/ps6vIWO1nx7mZ9ab98DGbA6ju6Zgj3KRR27YIEtg/eHeUN3+c22lVHcCPw8drIFapEVPNJwpQlyoCMuFOsybFBQFRuAu6ARzKrgOnjJ7FkkN8oakVcj6C67RGkcXcbsnSo4CUeQ2gH9qPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251871; c=relaxed/simple;
	bh=2w9n1ebv7JIiAM6iAMFJs2zl5Da5ijt2vVC0a54ryI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8YD0WRZ3g4DV9T981eHKdaobFN+RKcba7VnDPYTY2d8xfJQP4fD4yFJHYN2oP6pEW7o3PsVWHWU2XnQ28KlW6uOjrz5DaVyy+BGQnabEbtBfnitt5Ka1EZTQIJGkAq8/kdMwQW4YVBzoy6hGkFB8EP9ZZyOIf4dDO73scqThLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCUqfmMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C0C4CED6;
	Tue,  7 Jan 2025 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251871;
	bh=2w9n1ebv7JIiAM6iAMFJs2zl5Da5ijt2vVC0a54ryI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCUqfmMjpM01qfJjNL8MGVDE3PsE3nUKo24MJHWgSbyEQQiTbRR+jIbfH1N6Gp8F/
	 8DJiL1iX7Aj1YfqJdSPNBcKbHXm8IJtkQ8H89lE2aSu3OmVn5ACoq0UB3DB3yEQuf6
	 n2lWCAVnniVnKhU6S1d3V+9JhSfNasNoWqltICkzXvjGb346pAOMGehWYJayyyEsSq
	 17eSQ/si6t3o48UUkhw8GpemkxvtjnJ0dCki7dNzS7X1K+CXlgAgpAnsRX7uNctemO
	 TGWDsUbj8pJtgODQn+RuhU5ci4eA99rmKxiCs9ZTL/6rmRQzuAoxS9WNGoIJGbO9Qa
	 6D/0aRH8upYzQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests/ftrace: Fix to use remount when testing mount GID option
Date: Tue,  7 Jan 2025 21:11:07 +0900
Message-ID: <173625186741.1383744.16707876180798573039.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173625185823.1383744.4020760882101555349.stgit@devnote2>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix mount_options.tc to use remount option to mount the tracefs.
Since the current implementation does not umount the tracefs,
this test always fails because of -EBUSY error.
Using remount option will allow us to change the mount option.

Fixes: 8b55572e5180 ("tracing/selftests: Add tracefs mount options test")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 .../ftrace/test.d/00basic/mount_options.tc         |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
index 35e8d47d6072..8a7ce647a60d 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -15,11 +15,11 @@ find_alternate_gid() {
 	tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f3
 }
 
-mount_tracefs_with_options() {
+remount_tracefs_with_options() {
 	local mount_point="$1"
 	local options="$2"
 
-	mount -t tracefs -o "$options" nodev "$mount_point"
+	mount -t tracefs -o "remount,$options" nodev "$mount_point"
 
 	setup
 }
@@ -81,7 +81,7 @@ test_gid_mount_option() {
 
 	# Unmount existing tracefs instance and mount with new GID
 	unmount_tracefs "$mount_point"
-	mount_tracefs_with_options "$mount_point" "$new_options"
+	remount_tracefs_with_options "$mount_point" "$new_options"
 
 	check_gid "$mount_point" "$other_group"
 
@@ -92,7 +92,7 @@ test_gid_mount_option() {
 
 	# Unmount and remount with the original GID
 	unmount_tracefs "$mount_point"
-	mount_tracefs_with_options "$mount_point" "$mount_options"
+	remount_tracefs_with_options "$mount_point" "$mount_options"
 	check_gid "$mount_point" "$original_group"
 }
 


