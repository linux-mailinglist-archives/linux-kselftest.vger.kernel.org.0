Return-Path: <linux-kselftest+bounces-2367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FB81C9F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D430B23D50
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382A18043;
	Fri, 22 Dec 2023 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WTmV8/F9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDBD527
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so17623995e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703248033; x=1703852833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3DIgQDPNUxa7RZs2ySWTeSV2mkBPOsrUg4r0CjPEpY=;
        b=WTmV8/F9lalJWwcB4nYTai/r3KpxegPUTatsZ4wAWIE39b4WtiYJ9YWH2BW+DGoxec
         2yOClsW3+nUNYNCW8g4DpnY3XnQxq2v2spW8oqag2P1AhFu3EDPbXPaL5hsjYVaiwcdi
         xmhu8M4X4ZIbDMLIwYe7rut50+nxHGuH1ChUPIR78jVmLzu/geQAC/jzUb0mdFVyqOBf
         BhjrMpnox5LNgFjYu4liJl3rrLaFLAB+/Uz8xMWhmXGQ128oSDHOqit3XlP+FfXA1zfG
         B/M2JMVpXSQIsn2jYjxEVNPo5F+TL2/6cVKYmt7tKzZjbr6EpkexEIKs+M9vxO2gPQi1
         TxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703248033; x=1703852833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3DIgQDPNUxa7RZs2ySWTeSV2mkBPOsrUg4r0CjPEpY=;
        b=Z4ZdPx65pDVbLLC5boI553DfLnAx2IU1V0fE1j/kJ8wHxy6OHnFgB79/JUfItbOF5s
         TU6hPCrCNTBMlUxzZsVY+4ON+2T+vjsQfG2fo+OzG9//fbmbX+ClFf1/djw5lpzymei4
         WjB+FC4n5MFcelrHTPkdAxmt+Ze2VVbyDKGwH7wmFLps2imDRzev8r7dSkOPkmTZU0ih
         45m22pIfzg1Yr/D3zJj+CQ4czbAUCPDwerw/C+bfzb4It+nC2rGsgBayeUPhSSde6nhh
         qYMfD7zQKVoN6WE0dlpSMQGvfMxBlByc5+GAVpliUpy8VBTVW7eWTy2rCfz5lcO3WSEG
         maFQ==
X-Gm-Message-State: AOJu0YzMloc2yOTVaXDYNO+p9TYGTD1Y94kOXmVfRdPllPIrWxLQnVGb
	hnyIRIUlFjxTMK1E5t+CAj9G1vXGzwmTjg==
X-Google-Smtp-Source: AGHT+IGFZG9RzTslIKByE8OsIbeGFMIcfeNY7ZzEx0oFHv/jTEByRHQmOvc283cFjKRR6SZqmF123Q==
X-Received: by 2002:a05:600c:2986:b0:40b:5e21:e27a with SMTP id r6-20020a05600c298600b0040b5e21e27amr638243wmd.103.1703248033203;
        Fri, 22 Dec 2023 04:27:13 -0800 (PST)
Received: from ?IPv6:2804:30c:1668:b300:8fcd:588d:fb77:ed04? ([2804:30c:1668:b300:8fcd:588d:fb77:ed04])
        by smtp.gmail.com with ESMTPSA id fj8-20020a05600c0c8800b004094e565e71sm6801715wmb.23.2023.12.22.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 04:27:13 -0800 (PST)
Message-ID: <5d7989b6a5ecc483b63397c838edb7133c1620d3.camel@suse.com>
Subject: Re: [PATCH] selftests/livepatch: fix and refactor new dmesg message
 code
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org, Alexander
 Gordeev <agordeev@linux.ibm.com>, Petr Mladek <pmladek@suse.com>
Date: Fri, 22 Dec 2023 09:27:06 -0300
In-Reply-To: <20231220151151.267985-1-joe.lawrence@redhat.com>
References: <20231220151151.267985-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 10:11 -0500, Joe Lawrence wrote:
> The livepatching kselftests rely on comparing expected vs. observed
> dmesg output.=C2=A0 After each test, new dmesg entries are determined by
> the
> 'comm' utility comparing a saved, pre-test copy of dmesg to post-test
> dmesg output.
>=20
> Alexander reports that the 'comm --nocheck-order -13' invocation used
> by
> the tests can be confused when dmesg entry timestamps vary in
> magnitude
> (ie, "[=C2=A0=C2=A0 98.820331]" vs. "[=C2=A0 100.031067]"), in which case=
,
> additional
> messages are reported as new.=C2=A0 The unexpected entries then spoil the
> test results.
>=20
> Instead of relying on 'comm' or 'diff' to determine new testing dmesg
> entries, refactor the code:
>=20
> =C2=A0 - pre-test=C2=A0 : log a unique canary dmesg entry
> =C2=A0 - test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : run tests, log messages
> =C2=A0 - post-test : filter dmesg starting from pre-test message
>=20
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Closes:
> https://lore.kernel.org/live-patching/ZYAimyPYhxVA9wKg@li-008a6a4c-3549-1=
1b2-a85c-c5cc2836eea2.ibm.com/
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

I liked the solution. As I don't speak awk I had to do some manual
testing to understand that the syntax you used "prints everything after
the $last_dmesg_msg message on dmesg". Either way, it's better then
using 'comm' utility. I tested on my x86_64 VM, and the tests passed as
expected.

LGTM, so

Tested-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>=20

> ---
> =C2=A0.../testing/selftests/livepatch/functions.sh=C2=A0 | 37 +++++++++--=
------
> --
> =C2=A01 file changed, 17 insertions(+), 20 deletions(-)
>=20
> diff --git a/tools/testing/selftests/livepatch/functions.sh
> b/tools/testing/selftests/livepatch/functions.sh
> index c8416c54b463..b1fd7362c2fe 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -42,17 +42,6 @@ function die() {
> =C2=A0	exit 1
> =C2=A0}
> =C2=A0
> -# save existing dmesg so we can detect new content
> -function save_dmesg() {
> -	SAVED_DMESG=3D$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
> -	dmesg > "$SAVED_DMESG"
> -}
> -
> -# cleanup temporary dmesg file from save_dmesg()
> -function cleanup_dmesg_file() {
> -	rm -f "$SAVED_DMESG"
> -}
> -
> =C2=A0function push_config() {
> =C2=A0	DYNAMIC_DEBUG=3D$(grep '^kernel/livepatch'
> /sys/kernel/debug/dynamic_debug/control | \
> =C2=A0			awk -F'[: ]' '{print "file " $1 " line " $2
> " " $4}')
> @@ -99,7 +88,6 @@ function set_ftrace_enabled() {
> =C2=A0
> =C2=A0function cleanup() {
> =C2=A0	pop_config
> -	cleanup_dmesg_file
> =C2=A0}
> =C2=A0
> =C2=A0# setup_config - save the current config and set a script exit trap
> that
> @@ -280,7 +268,15 @@ function set_pre_patch_ret {
> =C2=A0function start_test {
> =C2=A0	local test=3D"$1"
> =C2=A0
> -	save_dmesg
> +	# Dump something unique into the dmesg log, then stash the
> entry
> +	# in LAST_DMESG.=C2=A0 The check_result() function will use it to
> +	# find new kernel messages since the test started.
> +	local last_dmesg_msg=3D"livepatch kselftest timestamp: $(date
> --rfc-3339=3Dns)"
> +	log "$last_dmesg_msg"
> +	loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
> +		die "buffer busy? can't find canary dmesg message:
> $last_dmesg_msg"
> +	LAST_DMESG=3D$(dmesg | grep "$last_dmesg_msg")
> +
> =C2=A0	echo -n "TEST: $test ... "
> =C2=A0	log "=3D=3D=3D=3D=3D TEST: $test =3D=3D=3D=3D=3D"
> =C2=A0}
> @@ -291,23 +287,24 @@ function check_result {
> =C2=A0	local expect=3D"$*"
> =C2=A0	local result
> =C2=A0
> -	# Note: when comparing dmesg output, the kernel log
> timestamps
> -	# help differentiate repeated testing runs.=C2=A0 Remove them
> with a
> -	# post-comparison sed filter.
> -
> -	result=3D$(dmesg | comm --nocheck-order -13 "$SAVED_DMESG" - |
> \
> +	# Test results include any new dmesg entry since LAST_DMESG,
> then:
> +	# - include lines matching keywords
> +	# - exclude lines matching keywords
> +	# - filter out dmesg timestamp prefixes
> +	result=3D$(dmesg | awk -v last_dmesg=3D"$LAST_DMESG" 'p; $0 =3D=3D
> last_dmesg { p=3D1 }' | \
> =C2=A0		 grep -e 'livepatch:' -e 'test_klp' | \
> =C2=A0		 grep -v '\(tainting\|taints\) kernel' | \
> =C2=A0		 sed 's/^\[[ 0-9.]*\] //')
> =C2=A0
> =C2=A0	if [[ "$expect" =3D=3D "$result" ]] ; then
> =C2=A0		echo "ok"
> +	elif [[ "$result" =3D=3D "" ]] ; then
> +		echo -e "not ok\n\nbuffer overrun? can't find canary
> dmesg entry: $LAST_DMESG\n"
> +		die "livepatch kselftest(s) failed"
> =C2=A0	else
> =C2=A0		echo -e "not ok\n\n$(diff -upr --label expected --
> label result <(echo "$expect") <(echo "$result"))\n"
> =C2=A0		die "livepatch kselftest(s) failed"
> =C2=A0	fi
> -
> -	cleanup_dmesg_file
> =C2=A0}
> =C2=A0
> =C2=A0# check_sysfs_rights(modname, rel_path, expected_rights) - check
> sysfs


