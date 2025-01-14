Return-Path: <linux-kselftest+bounces-24467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3BA10D64
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BBF3ACE61
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFB1D3576;
	Tue, 14 Jan 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AKw3t96T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24E23245A
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875091; cv=none; b=DYrVTl8Zkx0qwLXbD/uZ8ZQjnYcaT3C8n4b6ZpRqvbzPdAPOz0h3VhuVAIwFGCuMYOLQjgsuyP29w1Q+U8dylQFxfo0qDEXZ9RR5FOBIoknnxxQ1S9wuadvanR/bGpbC4v4wfs2//QAdWd8G/Fc9C06Imz94J4FKjFVHo07Vzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875091; c=relaxed/simple;
	bh=wpqN1Cft3TcGdK334NFRNrhfQUADVPSA7qO0z3zoP2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKQhU6qAME4dM7WxmoV7fCwCbOsuR8pNZBwgDddSr13AjqA+E/XwXtwm+PTplYP2WBqOJbd9c4e2VRTcE1izcSh1VLo4UT43P3JVHUYyNO2m6ojwxU7MZUMP7OlbHrQNTSDgUDm4LSKSfcNH6e1fEcByfJSn5aQHOMnfCHKOZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AKw3t96T; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so2454643a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736875087; x=1737479887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26cmflZb066/x6GO76FljjG7xVkAeMYqvCCcfNiU3Vc=;
        b=AKw3t96TvBS6O75Tlfcu0FmWWZwOa7nPsgDLGt93By+SHoEpw3sg6Dzr5+mk9o7NGw
         39ro7BSH1RF5yga5L+P4Gx28XnCBdkwDYSb61A8rUzq7BVGtVEB9K0mFq5JWugpjxbjq
         iFc9IOEQehfdSnsTONQH8P1yajrdoTUoRgQQR1qijPJiNb5aQFbO8jDaQvkg6KWLbJ43
         AEPITkGKgXoyswZsTEwthXKEGYtUOFdYXE37qgT9A71UdnYG0FgO+lSkos8dVAOWqFRK
         EuCX++BxNk+IQ3Na3cryZdm761DV3R4l463qMS1JSPSJ6RZTf6zUYdD9PtdnOqFnsTth
         ncOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736875087; x=1737479887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26cmflZb066/x6GO76FljjG7xVkAeMYqvCCcfNiU3Vc=;
        b=lP4xTFBkz3aspZHaUBLasuTqBg0NxzxB3dKEdlF629/fEDpWDEJVyvPErzYaNIfkzY
         QHJS/LFjQ0Dq9+BUEt5nSSevs4PCASQ61MfXYF7b6fbk0hPHiWk7/C4Hisp351gRLvZr
         k75SWmqdks3yXvCUmEg/hDIZJi6G8fFr3fq+p3Avvk4nlsIdEpM8f3Zw3qhQGkyyYJ8t
         3eNoFPOaEH8enJExXyU7OY3A1lNQtY+HY676QFCfW/rCrxZuyZuUOwr+MMe7+fmBQuD2
         H0hSudc5KYBPeBynvkHAOGBqTQyFO/5HPZ/4/wH8NHTWP4h4k9IO0FWW24IC8oqhsPzr
         u3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZh51b8CzHjdCqBLS9atyeGOWuRFt6nXqnoZ4FNehpjEc+1Z1hD5vsdhDIkwY75Lwt+2zyiZBwYzlOk4oiMJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjUtJyUzVeCMpKU81oZi8kI+UT9s0XaHsg/zXDgP/tPdp2Sft
	XgiQqxOUr7Hbx8EmcpGROyqdr9+VuMQV98BYdeXz2BjB01MIkq7N12yr410pO2U=
X-Gm-Gg: ASbGncv/ogPXP6eK3Nn7JLg+T/Ilydl4LBiddMW2Io//0fQMQJbrGchlrfZR/TxMj45
	q4ugxaxvVsJ3mn/f35nSBOdOuZjyN811mNIK7ty/sxmXOtbv0p/H2GQdJTbM0Kz5chT4E8zMyyk
	KSO/ONjTQpIfC5C1KiJSvZIcYNTjTRww7stEu//dlb4pwQeejIvTJTYYOq1TKotYUDT/5+YslIv
	CEm9flPJURr6IXQDWodrtdyLR5aQcDwyFBqMv8DQkL6cTSue4hhT+FWaWagY7P9FolizCDOCTWC
	ucNJo/y+RQua1pit35k=
X-Google-Smtp-Source: AGHT+IHTNDE6OFYqw/IC7av4Dymh/XxGZbIt/B/dtSZsBph45JtXr/urz+mZ5NLetZ2D+o4mK6riHg==
X-Received: by 2002:a17:907:3d91:b0:ab2:c0b0:3109 with SMTP id a640c23a62f3a-ab2c3d4c85emr1680574566b.21.1736875087499;
        Tue, 14 Jan 2025 09:18:07 -0800 (PST)
Received: from ?IPv6:2804:5078:803:5200:58f2:fc97:371f:2? ([2804:5078:803:5200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723185484d5sm4726836a34.26.2025.01.14.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:18:06 -0800 (PST)
Message-ID: <12c6681e2d13994c2efd5d25372293b9f53a9f8a.camel@suse.com>
Subject: Re: [PATCH v2] selftests: livepatch: test if ftrace can trace a
 livepatched function
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>,  Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Felipe Xavier <felipe_life@live.com>
Date: Tue, 14 Jan 2025 14:18:02 -0300
In-Reply-To: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
References: <20250111-ftrace-selftest-livepatch-v2-1-9f4ff90f251a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-11 at 15:42 -0300, Filipe Xavier wrote:
> This new test makes sure that ftrace can trace a
> function that was introduced by a livepatch.
>=20
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>

Thanks for the new test Filipe!

I have some nits below, but these don't need to be addressed for the
test to be merged. Either way,

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>



> ---
> Changes in v2:
> - functions.sh: added reset tracing on push and pop_config.
> - test-ftrace.sh: enabled tracing_on before test init.
> - nitpick: added double quotations on filenames and fixed some
> wording.=20
> - Link to v1:
> https://lore.kernel.org/r/20250102-ftrace-selftest-livepatch-v1-1-84880ba=
efc1b@gmail.com
> ---
> =C2=A0tools/testing/selftests/livepatch/functions.sh=C2=A0=C2=A0 | 14 +++=
+++++++
> =C2=A0tools/testing/selftests/livepatch/test-ftrace.sh | 33
> ++++++++++++++++++++++++
> =C2=A02 files changed, 47 insertions(+)
>=20
> diff --git a/tools/testing/selftests/livepatch/functions.sh
> b/tools/testing/selftests/livepatch/functions.sh
> index
> e5d06fb402335d85959bafe099087effc6ddce12..e6c13514002dae5f8d7461f90b8
> 241ab43024ea4 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -62,6 +62,9 @@ function push_config() {
> =C2=A0			awk -F'[: ]' '{print "file " $1 " line " $2
> " " $4}')
> =C2=A0	FTRACE_ENABLED=3D$(sysctl --values kernel.ftrace_enabled)
> =C2=A0	KPROBE_ENABLED=3D$(cat "$SYSFS_KPROBES_DIR/enabled")
> +	TRACING_ON=3D$(cat "$SYSFS_DEBUG_DIR/tracing/tracing_on")
> +	CURRENT_TRACER=3D$(cat
> "$SYSFS_DEBUG_DIR/tracing/current_tracer")
> +	FTRACE_FILTER=3D$(cat
> "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter")
> =C2=A0}
> =C2=A0
> =C2=A0function pop_config() {
> @@ -74,6 +77,17 @@ function pop_config() {
> =C2=A0	if [[ -n "$KPROBE_ENABLED" ]]; then
> =C2=A0		echo "$KPROBE_ENABLED" >
> "$SYSFS_KPROBES_DIR/enabled"
> =C2=A0	fi
> +	if [[ -n "$TRACING_ON" ]]; then
> +		echo "$TRACING_ON" >
> "$SYSFS_DEBUG_DIR/tracing/tracing_on"
> +	fi
> +	if [[ -n "$CURRENT_TRACER" ]]; then
> +		echo "$CURRENT_TRACER" >
> "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +	fi
> +	if [[ "$FTRACE_FILTER" =3D=3D *"#"* ]]; then
> +		echo > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +	elif [[ -n "$FTRACE_FILTER" ]]; then
> +		echo "$FTRACE_FILTER" >
> "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +	fi
> =C2=A0}

I believe that this could be a separate patch, since this is new
functionality that's being added to functions.sh, and not exactly
related to the new test.

> =C2=A0
> =C2=A0function set_dynamic_debug() {
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh
> b/tools/testing/selftests/livepatch/test-ftrace.sh
> index
> fe14f248913acbec46fb6c0fec38a2fc84209d39..66af5d726c52e48e5177804e182
> b4ff31784d5ac 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -61,4 +61,37 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
> =C2=A0% rmmod $MOD_LIVEPATCH"
> =C2=A0
> =C2=A0
> +# - verify livepatch can load
> +# - check if traces have a patched function
> +# - unload livepatch and reset trace
> +
> +start_test "trace livepatched function and check that the live patch
> remains in effect"
> +
> +TRACE_FILE=3D"$SYSFS_DEBUG_DIR/tracing/trace"
> +FUNCTION_NAME=3D"livepatch_cmdline_proc_show"
> +
> +load_lp $MOD_LIVEPATCH
> +
> +echo 1 > "$SYSFS_DEBUG_DIR/tracing/tracing_on"
> +echo $FUNCTION_NAME > "$SYSFS_DEBUG_DIR/tracing/set_ftrace_filter"
> +echo "function" > "$SYSFS_DEBUG_DIR/tracing/current_tracer"
> +echo "" > "$TRACE_FILE"
> +
> +if [[ "$(cat /proc/cmdline)" !=3D "$MOD_LIVEPATCH: this has been live
> patched" ]] ; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +grep -q $FUNCTION_NAME "$TRACE_FILE"
> +FOUND=3D$?
> +
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +if [ "$FOUND" -eq 1 ]; then
> +	echo -e "FAIL\n\n"
> +	die "livepatch kselftest(s) failed"
> +fi
> +
> +
> =C2=A0exit 0

The test works, and that's very cool. But when running locally, I find
the if we miss check_result call it doesn't add a newline after the
"ok":

...
# timeout set to 0                                                   =20
# selftests: livepatch: test-ftrace.sh                               =20
# TEST: livepatch interaction with ftrace_enabled sysctl ... ok      =20
# TEST: trace livepatched function and check that the live patch
remains in effect ... ok 5 selftests: livepatch: test-ftrace.sh      =20
# timeout set to 0                                                   =20
# selftests: livepatch: test-sysfs.sh =20
...

If the check_result below is added the output if sane again:

...
# selftests: livepatch: test-ftrace.sh
# TEST: livepatch interaction with ftrace_enabled sysctl ... ok
# TEST: trace livepatched function and check that the live patch
remains in effect ... ok
ok 5 selftests: livepatch: test-ftrace.sh
...

I checked and this would be the only one test without using
check_result, so maybe we should add this either way? I'm not sure what
you guys think about it.


diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh
b/tools/testing/selftests/livepatch/test-ftrace.sh
index 66af5d726c52..135c0fb17a98 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -93,5 +93,18 @@ if [ "$FOUND" -eq 1 ]; then
 	die "livepatch kselftest(s) failed"
 fi
=20
+check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% echo 0 > $SYSFS_KLP_DIR/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
=20
 exit 0

>=20
> ---
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> change-id: 20250101-ftrace-selftest-livepatch-161fb77dbed8
>=20
> Best regards,


