Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3C4D0B44
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 23:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiCGWjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiCGWji (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 17:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8151C109
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 14:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646692722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WwCj9tmeEF9G3sFW68kDXMvHQYtm97AqiL1Iqd+awRI=;
        b=NnyK11KBxNzZt2KsOCvVdMjvOl3l/43i2Ydd0XUdCGk3q7H7tCHTNV2qhif9eYHO2H02nw
        KjtYY9ga+De7W5Z0iSyvD+XFSBLexmUQn3db0M05PWAIXf1GIXLpJ+fhdkTfnlcabtimQB
        jki7uts8hiScVwhUtpd5F8A6HFBGbLA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-nSiWqWHePrmSpPh010rX5A-1; Mon, 07 Mar 2022 17:38:40 -0500
X-MC-Unique: nSiWqWHePrmSpPh010rX5A-1
Received: by mail-wr1-f70.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so4953367wro.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Mar 2022 14:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WwCj9tmeEF9G3sFW68kDXMvHQYtm97AqiL1Iqd+awRI=;
        b=AkaRjaF8tRh6KCU9dENi23eAzLkIPpAHjC1tKPwaCM8Mr/UJdA0NG1raFrSQa8meKu
         I354RHWPfD44fQUviL86rGb+opiyisiEpQ/xBcKhxBjuq1hBp+R1DjhkBFQz+MB6L3Vh
         p6QaAxtrLKEdwb39IsE4I+U5JQEt/z233ZxKZ3tJOXA1bfWeZrDGjEE+LY0/fD9jc678
         JJCq7ADmzmzaSzQ8Sqf0jC+i7s8UXcYDcILTSjSk4ex2NYFRs5680io6f/z/xyOpvMCT
         4bLOW4fq8qzxZZDG7dMK4zTMSjbnzLs8rgoW0JGMT9cfv8IvvER7wzMJYHWrm4RGGtnb
         Yq7g==
X-Gm-Message-State: AOAM5317oD1epnq0UPo/k2GXmtVQ2A646rQJLtKPbbTdh5do7ETyC7N1
        QahpB6N0eRlYN8Ed4v8B9PeAeBFBZy5Ed6YoMdn+KWCTo6PMQ2q0EAWr52LAs8JG5pASfRMMkUf
        P/mFbYkLH89ZHINbS1bwo4GjdAcke
X-Received: by 2002:adf:c40e:0:b0:1f1:d719:52d2 with SMTP id v14-20020adfc40e000000b001f1d71952d2mr10257410wrf.105.1646692719617;
        Mon, 07 Mar 2022 14:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiIYBa+X7uMcs0qmPxYR5fSqFB8ajs0/BrHplSbZfFfuQX/9S2EfHij2ixsVzr04C2s4PGJA==
X-Received: by 2002:adf:c40e:0:b0:1f1:d719:52d2 with SMTP id v14-20020adfc40e000000b001f1d71952d2mr10257399wrf.105.1646692719428;
        Mon, 07 Mar 2022 14:38:39 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c228700b00389865c646dsm652524wmf.14.2022.03.07.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:38:39 -0800 (PST)
Date:   Mon, 7 Mar 2022 23:38:37 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: pmtu.sh: Kill tcpdump processes launched by
 subshell.
Message-ID: <0378c55466d8d1f7b6d99d581811d49429e1f4e7.1646691728.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cleanup() function takes care of killing processes launched by the
test functions. It relies on variables like ${tcpdump_pids} to get the
relevant PIDs. But tests are run in their own subshell, so updated
*_pids values are invisible to other shells. Therefore cleanup() never
sees any process to kill:

$ ./tools/testing/selftests/net/pmtu.sh -t pmtu_ipv4_exception
TEST: ipv4: PMTU exceptions                                         [ OK ]
TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]

$ pgrep -af tcpdump
6084 tcpdump -s 0 -i veth_A-R1 -w pmtu_ipv4_exception_veth_A-R1.pcap
6085 tcpdump -s 0 -i veth_R1-A -w pmtu_ipv4_exception_veth_R1-A.pcap
6086 tcpdump -s 0 -i veth_R1-B -w pmtu_ipv4_exception_veth_R1-B.pcap
6087 tcpdump -s 0 -i veth_B-R1 -w pmtu_ipv4_exception_veth_B-R1.pcap
6088 tcpdump -s 0 -i veth_A-R2 -w pmtu_ipv4_exception_veth_A-R2.pcap
6089 tcpdump -s 0 -i veth_R2-A -w pmtu_ipv4_exception_veth_R2-A.pcap
6090 tcpdump -s 0 -i veth_R2-B -w pmtu_ipv4_exception_veth_R2-B.pcap
6091 tcpdump -s 0 -i veth_B-R2 -w pmtu_ipv4_exception_veth_B-R2.pcap
6228 tcpdump -s 0 -i veth_A-R1 -w pmtu_ipv4_exception_veth_A-R1.pcap
6229 tcpdump -s 0 -i veth_R1-A -w pmtu_ipv4_exception_veth_R1-A.pcap
6230 tcpdump -s 0 -i veth_R1-B -w pmtu_ipv4_exception_veth_R1-B.pcap
6231 tcpdump -s 0 -i veth_B-R1 -w pmtu_ipv4_exception_veth_B-R1.pcap
6232 tcpdump -s 0 -i veth_A-R2 -w pmtu_ipv4_exception_veth_A-R2.pcap
6233 tcpdump -s 0 -i veth_R2-A -w pmtu_ipv4_exception_veth_R2-A.pcap
6234 tcpdump -s 0 -i veth_R2-B -w pmtu_ipv4_exception_veth_R2-B.pcap
6235 tcpdump -s 0 -i veth_B-R2 -w pmtu_ipv4_exception_veth_B-R2.pcap

Fix this by running cleanup() in the context of the test subshell.
Now that each test cleans the environment after completion, there's no
need for calling cleanup() again when the next test starts. So let's
drop it from the setup() function. This is okay because cleanup() is
also called when pmtu.sh starts, so even the first test starts in a
clean environment.

Note: PAUSE_ON_FAIL is still evaluated before cleanup(), so one can
still inspect the test environment upon failure when using -p.

Fixes: a92a0a7b8e7c ("selftests: pmtu: Simplify cleanup and namespace names")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 543ad7513a8e..1db670a01f9b 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -865,7 +865,6 @@ setup_ovs_bridge() {
 setup() {
 	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
-	cleanup
 	for arg do
 		eval setup_${arg} || { echo "  ${arg} not supported"; return 1; }
 	done
@@ -1836,6 +1835,10 @@ run_test() {
 
 	unset IFS
 
+	# Since cleanup() relies on variables modified by this subshell, it
+	# has to run in this context.
+	trap cleanup EXIT
+
 	if [ "$VERBOSE" = "1" ]; then
 		printf "\n##########################################################################\n\n"
 	fi
-- 
2.21.3

