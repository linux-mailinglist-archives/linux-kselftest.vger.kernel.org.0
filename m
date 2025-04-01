Return-Path: <linux-kselftest+bounces-29975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC59A775BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964173A8DDB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5D1E7C11;
	Tue,  1 Apr 2025 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhPQTNJ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUrGU8g+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABED1078F;
	Tue,  1 Apr 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494222; cv=none; b=UgHTjilOAj2AvR4pXs2bYBUQQtgsv/Hm2WG/mginBur5F+movs3Xc6RMFL3nOSo/ULKBEiyPArgVCzs10uqJurWLNvmZBk1U61019euD4mS/viTAw3bForQGztLHm7pyaxs4aCbSxH8JT/W/037CSKjCHHpGxXx6lQIwFICW74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494222; c=relaxed/simple;
	bh=qNX3h8e3ZikgfkMzqr+0T/Vi5N/3/tWNAwMgnRCpSII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wg+zTkDSl3YxV4Bmu+VWpbXxQg+v9DFYeZaSXJgQTFT/AjCt0kWl11ErKQte61AZYOTQRlrAayHjDGQe6WsOpXtQB3mcql4qrRL74nihRBM9Y69nBbmKG/rczoWRjB6WrT20SU+onVX4hGZAs61aPYnP379O9ie7i963Yd/sTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhPQTNJ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUrGU8g+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743494219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/B1pxpgVYUmmB5x73U3iOsGDOYkcEFgBX4uiIbpfXs=;
	b=qhPQTNJ0Tg+xtYxIaAlTRGTFVPR7m7rdQpc7MjbbY0EOsZoTxeW+SF46QPX1rWQCEVGr5P
	JMjmcb+88aVz3K2EXoiQ66maSP+lE6zvF509HV4o+fh2/XU6BsHN0P7KZp+VXLq+HSHTf3
	VxFfPPLovvtvrvo1tBmhIWTbvB/GxY9tGuFh+atDCX8B7HOaMv46yHqbvQqR8J/xFW2+Sn
	N1A98MuqW9i84YeA3wMgl/no3nRWeq41uU1iMA7PR8rbeHI9mBWLTP1MqK8WJzaJL5iL2W
	nadPkqqjMa06kD2AT12M3f+ICjLqM+dhurY8R4TY0PrTfxaWTkRIt1yqfJkNcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743494219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/B1pxpgVYUmmB5x73U3iOsGDOYkcEFgBX4uiIbpfXs=;
	b=zUrGU8g+iLh6KBA8ZM8XYmifnxEkmUQ8O3ZR+6qgypiWsGiN1BnBU+dtmBFSoE+rRQ9d6m
	yzGyC64vFlb7m0Bw==
To: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 1/3] selftests: coredump: Properly initialize pointer
In-Reply-To: <b595166b7ece013b371c2bac1098533f1ffa12d0.1743438749.git.namcao@linutronix.de>
References: <cover.1743438749.git.namcao@linutronix.de>
 <b595166b7ece013b371c2bac1098533f1ffa12d0.1743438749.git.namcao@linutronix.de>
Date: Tue, 01 Apr 2025 10:02:58 +0206
Message-ID: <8434esmi0l.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-03-31, Nam Cao <namcao@linutronix.de> wrote:
> The buffer pointer "line" is not initialized. This pointer is passed to
> getline().

Ouch.

> It can still work if the stack is zero-initialized, because getline() can
> work with a NULL pointer as buffer.
>
> But this is obviously broken. This bug shows up while running the test on a
> riscv64 machine.
>
> Fix it by properly initializing the pointer.
>
> Fixes: 15858da53542 ("selftests: coredump: Add stackdump test")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  tools/testing/selftests/coredump/stackdump_test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index 137b2364a082..1dc54e128586 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -100,6 +100,8 @@ TEST_F(coredump, stackdump)
>  	FILE *file;
>  	pid_t pid;
>  
> +	line = NULL;

The syntax of getline(3) is quite interesting, since it
allocates/reallocates/uses the lineptr as needed and possibly requires
the application to free the data. I recommend moving the initialization
down to the getline() call and also add the corresponding free().

Something like this:

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index 137b2364a082..c23cf95c3f6d 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -138,10 +138,12 @@ TEST_F(coredump, stackdump)
 	ASSERT_NE(file, NULL);
 
 	/* Step 4: Make sure all stack pointer values are non-zero */
+	line = NULL;
 	for (i = 0; -1 != getline(&line, &line_length, file); ++i) {
 		stack = strtoull(line, NULL, 10);
 		ASSERT_NE(stack, 0);
 	}
+	free(line);
 
 	ASSERT_EQ(i, 1 + NUM_THREAD_SPAWN);
 
Because of how getline() works, technically your patch is good
enough. But we should probably excercise more precision in the use of
getline() so as to set a good example.

John Ogness

