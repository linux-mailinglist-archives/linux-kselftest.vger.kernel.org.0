Return-Path: <linux-kselftest+bounces-23731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1609FA9D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 04:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002D81884E62
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 03:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A980038;
	Mon, 23 Dec 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCWTuMHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1D64A;
	Mon, 23 Dec 2024 03:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734925590; cv=none; b=L/AZEQnS1hQmWxSW/fiY8htiKENLlPVUG586nk3jBsyW0AK4c1oaAvVLrXqvBvbXPXXRbhrUORNkN0cLlR0yNLyqOZRIG54gzkcJeDfFywpHq62fUywhX+ISWRtxHbqdnnhe4F/avJ6IWNdBvlE5eb0VMRmcxSWbFGiJxYcZ8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734925590; c=relaxed/simple;
	bh=JfeOxWnyv3SUEHJqwMm4FEys+TylQmQpBfVr7lhI7p8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fYUyN78rcatLA80RvIkyjy6YvnEHHngSUnt+JSzwQfytdshVl+/T/h1B7UL4IVFw3oJ+7t7m77y1ST9Ra1t6L+PQGG5pcTsBQWtM3vuE5UfmqVewjUDtIQKU8RsAbtvWEZ5FrEqTPCscwmYTfXPtmMOvpI8Em/J+yvugrlERG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCWTuMHy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b98a2e3b3eso160533385a.2;
        Sun, 22 Dec 2024 19:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734925588; x=1735530388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFRQRoeZrGXA6lHV5tJUaxXAjSIRQ81AYPmgj+PQGfc=;
        b=ZCWTuMHyYHq6pnnSG7CMsRPkQbf8qwGFlZcTTL6KPbP90/5xAJYYhLw/j+TvcwRSkZ
         1aOIYDyvoWm9nEpO3Lt7Hfk1D27Eb5bAih4T1ziPOCLInXpKErJ6P65U/J9/hIC9wbqw
         KJkvMcC9Gd766dfuNzCvreVaEgIYhtNegTHDKc60qd1ZPK19JLbEITO7Ea1Lc2TM2HEe
         5z/lFKCAi0nz8zFCCaqo2uttzaxSpX54GpgaEIlcv9CJCdC9Hxmq6MJFOWqaBzLymexr
         MPgf+xG8IxqZsIhSyQRH9j+nErSufuILNhPpkExx6k1LBkqCvw9bNYd00U8+U/+a5wG7
         YiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734925588; x=1735530388;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YFRQRoeZrGXA6lHV5tJUaxXAjSIRQ81AYPmgj+PQGfc=;
        b=q2blox0EpTrlS8/xlCWpwOsbhxHe8Neeqvwp6kgJFwkr/Wk4AsmtAmIfSsZfsGe44H
         Q3n+2L+I+SOyy38o7N1gOdvl8hF/wW8l+S0RpwGLiF7fkXlU5dECHyLBej+1dvhiVEvt
         Ched2HDqd007xL+EKgwlfaN4iynNLtHGkeEJ2Zk3gKWimbef76pVtZTveuLmHSbpinsm
         OicSP9vXpgfxDgRk1am+b6HqRaF5kEliMZoVfCLYFHS9Yx3EyOPIezMhUhGlfk4S70Hq
         o1l4k2j3m1zpnqwKWlnlSB0vb+9xIf+t5ryRpT3Dhlvpbb6HeZP7x7O5cdw1G3wD2mq1
         vb2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJevnT2OfXLP5OrZG1giy08KrXm3kyi0Pf45rsM3+M9l1vF/ueOThn4+9aOuG6uRovqVk2xJzH@vger.kernel.org, AJvYcCWauARTDKU00BnzMRb/mAn+9f8kl/ChnBTCOLgGTSzncWEuH4wJhZWCDePmGsJ8olloigfcV4TU8iCkiZZkVnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLDJCztPdVTULE7XUPEBBclxfyXPufSlYatelIrYyxrOG1w/g
	wzPXCQEIQCwZKs7QlgKObRi2XDmMCyoHAVv0+lbYN+H4QK9vL/mx
X-Gm-Gg: ASbGncuofTHANix/PfrIGN4QMFp+y690UKj77dqMbRDtssXamFcLn/SlwLteXqotP4r
	0IfpUx/v/fnVfg18PcWK4E/wNzTn346thAoPXvIc/sOfTHC18UmDn8JheafOIm3ZooAB4FeSKQQ
	57DcPzPYPu5srD9Miqf42G3V63s0vCQ8Bl8dO7hWrqiPHIXPi46tGziBNo9sUteSRdtvm5PCjm1
	TAB2BGShyT6XlUGO1+sveQHJZ/BeOUt5RxPgow6Bn72Q1s1CcRW1Mma1OqghK2EH1v/3Ssl8nJv
	+ZXl3t1CE++Hi9juwyJDPOr2jOhNKuqDVw==
X-Google-Smtp-Source: AGHT+IFxZ/PFYtoRTHD5I4xzQc+7Q8s0I7jc6H31fsySfBtgWmvkwzOLwyzllox0LcldHagbR+4M3g==
X-Received: by 2002:a05:620a:191f:b0:7b6:d3e5:4f45 with SMTP id af79cd13be357-7b9ba79b519mr1949539685a.30.1734925587893;
        Sun, 22 Dec 2024 19:46:27 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2d15cfsm351932185a.34.2024.12.22.19.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 19:46:27 -0800 (PST)
Date: Sun, 22 Dec 2024 22:46:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Soham Chakradeo <sohamch.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 linux-kselftest@vger.kernel.org, 
 Soham Chakradeo <sohamch@google.com>
Message-ID: <6768dd1289ee2_3cff202943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241219180144.7cf5226c@kernel.org>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
 <20241218100013.0c698629@kernel.org>
 <19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
 <676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
 <20241219180144.7cf5226c@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import multiple
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 19 Dec 2024 14:31:44 -0500 Willem de Bruijn wrote:
> > All three timestamping flakes are instances where the script expects
> > the timestamp to be taken essentially instantaneously after the send
> > call.
> > 
> > This is not the case, and the delay is outside even the 14K tolerance.
> > I see occurrences of 20K. At some point we cannot keep increasing the
> > tolerance, perhaps.
> 
> I pinned the other services away and gave the packetdrill tester its
> own cores. Let's see how much of a difference this makes.
> The net-next-2024-12-20--03-00 branch will be the first to have this.

Thanks. It does not seem to resolve the flakes.

At this point I think the best path is to run them in debug mode to
get coverage, but ignore errors. With the below draft patch, error
output is still logged. For instance:

# tcp_timestamping_partial.pkt:58: runtime error in recvmsg call: Bad timestamp 0 in scm_timestamping 0: expected=1734924748967958 (20000) actual=1734924748982069 (34111) start=1734924748947958
# ok 2 ipv6 # SKIP

Such timestamping test failures are fairly straightforward. We could
just increase the KSFT_MACHINE_SLOW timeout. But other tests see an
actual difference in TCP stack behavior, e.g., size of packet. That is
not addressed by a further relaxation of the tolerance.


+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -23,7 +23,7 @@ if [ $# -ne 1 ]; then
        ktap_exit_fail_msg "usage: $0 <script>"
        exit "$KSFT_FAIL"
 fi
-script="$1"
+script="$(basename $1)"
 
 if [ -z "$(which packetdrill)" ]; then
        ktap_skip_all "packetdrill not found in PATH"
@@ -31,16 +31,27 @@ if [ -z "$(which packetdrill)" ]; then
 fi
 
 declare -a optargs
+failfunc=ktap_test_fail
+
 if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
        optargs+=('--tolerance_usecs=14000')
+
+       declare -ar skip_list=(
+               "tcp_fast_recovery_prr-ss.*.pkt"
+               "tcp_timestamping.*.pkt"
+               "tcp_user_timeout_user-timeout-probe.pkt"
+               "tcp_zerocopy_epoll_.*.pkt"
+       )
+       readonly skip_pattern="^($(printf '%s|' "${skip_list[@]}"))$"
+       [[ "$script" =~ ${skip_pattern} ]] && failfunc=ktap_test_skip
 fi
 
 ktap_print_header
 ktap_set_plan 2
 
-unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
-       && ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
-       && ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
+unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $script > /dev/null \
+       && ktap_test_pass "ipv4" || $failfunc "ipv4"
+unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $script > /dev/null \
+       && ktap_test_pass "ipv6" || $failfunc "ipv6"


