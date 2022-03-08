Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9E4D2410
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 23:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350638AbiCHWQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 17:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbiCHWQG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440F154BCE
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 14:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646777708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6nIHOJmJA+rkjvbg8O1o1KH0J2z0YqG4K70ZRzEJTXc=;
        b=aKHQeQcGLsSV7wZF+hUASjuVUffkP39f7RXVIAMut7HlrL4mk77j1rV3zOFzCPkVZrLDTS
        Vd+M2r16Vjheh7shMBFHgoA2hsQ00+5nWN73Nim9QoLC60Z8X0+wFJejv6cHfINh8NaqAB
        XivCuI0ousLxXzXraQ8mRcGs3EtqYx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-fV8B-aMoNV-7lTKVZFz7aw-1; Tue, 08 Mar 2022 17:15:07 -0500
X-MC-Unique: fV8B-aMoNV-7lTKVZFz7aw-1
Received: by mail-wr1-f70.google.com with SMTP id m18-20020a5d4a12000000b00203731460e6so26552wrq.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 14:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6nIHOJmJA+rkjvbg8O1o1KH0J2z0YqG4K70ZRzEJTXc=;
        b=Cvek+p0Wf1Il+pN+S8Zi9UcvBtWaV5L+cJEmqR6vyoYq3DwBN88yGaFye0T0CepbL+
         eNXEFjhR4WG3VcbRVI/HiTVsZ1D8pIy63v6dcFdbzxlo+X4PpBbYxXn4sANjiap1lB5k
         1B15KoUdGzJv89am88z4vQbVC6AAF/clYa+kWthrBbCZVD5aNwBFylWkwsRrEgAyliel
         0bak7yWJ2VlHrG7uFNgnNwFspTMjI7x+Ps9d0T2wNLOF2ZBvK7fRhG6IPmkpRSjOoCI+
         Q8EOU255A5Z86Bg1BRnpRbu+Lf4AFo7ThoAfQHDsexBAoduxWqswRmQp9VX6/w3YcTtU
         ncbQ==
X-Gm-Message-State: AOAM532tUa+4mmTHsFlEBJ2fEprPqRWiYbDmXOG7fo2L+ACd3v8q+8Rp
        5/ulzECgfrCr1+tL98l2pCEj5AAHmG4XFFVQq8e+GQ4Obs2WJDX8Kyse0+cbQRa77tywJ5Wfjrm
        IALeHnxLgfvBVPSfEByLelELR+jHP
X-Received: by 2002:a5d:61ca:0:b0:1f0:22ef:bb9f with SMTP id q10-20020a5d61ca000000b001f022efbb9fmr14177712wrv.56.1646777706060;
        Tue, 08 Mar 2022 14:15:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUAdR2fAB8NkHsGlS31dTIoi/XqT+nhHeo0/XxxKYEYFt+c1zOjvRcGUy9zE1VzDBSBimJzA==
X-Received: by 2002:a5d:61ca:0:b0:1f0:22ef:bb9f with SMTP id q10-20020a5d61ca000000b001f022efbb9fmr14177703wrv.56.1646777705864;
        Tue, 08 Mar 2022 14:15:05 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm126364wrt.63.2022.03.08.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:05 -0800 (PST)
Date:   Tue, 8 Mar 2022 23:15:03 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/2] selftests: pmtu.sh: Kill nettest processes launched
 in subshell.
Message-ID: <55cb9255471e73eaa481779329d9d47c430dbd0a.1646776561.git.gnault@redhat.com>
References: <cover.1646776561.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646776561.git.gnault@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using "run_cmd <command> &", then "$!" refers to the PID of the
subshell used to run <command>, not the command itself. Therefore
nettest_pids actually doesn't contain the list of the nettest commands
running in the background. So cleanup() can't kill them and the nettest
processes run until completion (fortunately they have a 5s timeout).

Fix this by defining a new command for running processes in the
background, for which "$!" really refers to the PID of the command run.

Also, double quote variables on the modified lines, to avoid shellcheck
warnings.

Fixes: ece1278a9b81 ("selftests: net: add ESP-in-UDP PMTU test")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 2e8972573d91..694732e4b344 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -374,6 +374,16 @@ run_cmd() {
 	return $rc
 }
 
+run_cmd_bg() {
+	cmd="$*"
+
+	if [ "$VERBOSE" = "1" ]; then
+		printf "    COMMAND: %s &\n" "${cmd}"
+	fi
+
+	$cmd 2>&1 &
+}
+
 # Find the auto-generated name for this namespace
 nsname() {
 	eval echo \$NS_$1
@@ -670,10 +680,10 @@ setup_nettest_xfrm() {
 	[ ${1} -eq 6 ] && proto="-6" || proto=""
 	port=${2}
 
-	run_cmd ${ns_a} nettest ${proto} -q -D -s -x -p ${port} -t 5 &
+	run_cmd_bg "${ns_a}" nettest "${proto}" -q -D -s -x -p "${port}" -t 5
 	nettest_pids="${nettest_pids} $!"
 
-	run_cmd ${ns_b} nettest ${proto} -q -D -s -x -p ${port} -t 5 &
+	run_cmd_bg "${ns_b}" nettest "${proto}" -q -D -s -x -p "${port}" -t 5
 	nettest_pids="${nettest_pids} $!"
 }
 
-- 
2.21.3

