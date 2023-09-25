Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4D7AD6F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIYLYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIYLYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 07:24:43 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6E100;
        Mon, 25 Sep 2023 04:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695641069; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XXN41uh2MugBFGEid7+EZCRU511mZUoHzHBSVqvNu6zaPKjmnVdOlnjGlOT/9IGkt/bkzMwnNJecMqI7sQRHlaNBRnH7qVhDhIpNLQiRSppceXMsTMLIPVWBCP9K00z8z8qlZuXEF/0TjY58mH5zCJJjlbBCfz2NVoz6FxPmsX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695641069; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=6QTBopM4AFokGMXe5eTyZo7tsMvC10D0AZEDxQ4I2I8=; 
        b=YMmnpyXNtdvVwcAzwmDdHA2dAMiw0VfMEW6cK83rb8lfX4ylzoKqKgVU4ToLiZt9rtnYW4VEYWJgmO3dIZJLPVAcFfU23ixEjMHbeJGTlND1FaGP1SMt9H1Db7LMZVTeEt/AqxSAESCoogD8WC0CA2FvhoHsF5pGeWRQvzRqLPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695641069;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=6QTBopM4AFokGMXe5eTyZo7tsMvC10D0AZEDxQ4I2I8=;
        b=o54JjpWDPBdbUjK0Rg6qowmJZnG4LnrpIyvskIVkd77Pak6ynmSwVAEl7+aQZ1P5
        p+qu/sQpUdyynBDpBenl5GLXcN7+/a/B7jICanBGJ40/Tnr9q7fE8l/UDphAY2mb5w9
        9nbXeLrGuId8gmoZ6UqWiR0pT4I2CyA+sKkGIC6s=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695641067825275.3232582858525; Mon, 25 Sep 2023 04:24:27 -0700 (PDT)
Date:   Mon, 25 Sep 2023 08:24:29 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     shuah@kernel.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC] selftests: Add dependencies information for kselftest
Message-ID: <z6mgbk3rho5xh37ufwxu5tkblvk3kw44fg6pr2qcalwcsx6hz4@ehd3k5sr5ixy>
References: <VI1P193MB0752C18200A14B449C863B1899FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P193MB0752C18200A14B449C863B1899FCA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/09/25 06:25PM, Juntong Deng wrote:
> Most of the tests in kselftest rely on external tools and libraries
> to run, which means that in order to run the tests effectively we need
> to have all the dependencies installed first.
> 
> But unfortunately, there is currently no way to know in advance what
> tools and libraries the tests in kselftest depend on, and can only be
> known when a test run fails.

Hello Juntong,

did you check if tools/testing/selftests/kselftest_deps.sh does what
you're after? It won't tell you what packages are missing because it's
distro-independent, but it tells you what libs your system is missing.

e.g.

(...)
Targets failed build dependency check on system: alsa bpf cachestat
capabilities clone3 filesystems fpu futex hid intel_pstate kvm landlock
membarrier memfd mm mqueue net netfilter powerpc ptp rseq rtc safesetid
sched seccomp timens timers user_events vDSO
-------------------------------------------------------- Missing
libraries system -lasound -lcap -lcap-ng -lcrypto -ldl -lelf -lfuse
-lgcc_s -lm -lmnl -lnuma -lpopt -lpthread -lrt -lz -pthread



Regards,
-	Ricardo
