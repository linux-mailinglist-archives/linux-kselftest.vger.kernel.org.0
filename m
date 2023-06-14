Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3042730B86
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFNX1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNX1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 19:27:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061831BC3;
        Wed, 14 Jun 2023 16:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZN9+NDHXrzulzUsBjxSBISyzTDfr/hxqeScKw4jYUp6FirHFcjqjoGhfKfuYA1JR/uFf/EZ4fMGMKtoO/0ukvirM+go4lReZLCqmBvAtwRAxoqQsWoI6UnJ1NRe1G5CCUrnlvJQ3L1dGGwcJxYhCrqp5Dfs5JSdj6XNdyv/bFqL7QB/kT8zN0fDDjEeDI6i2gmXmMAb2ydQbFsqng5JGPx08zPGcpOd+Q+7JHU6S1pYm/1miG069iV6PDUvy1oh6VyB2+/1v78TmTNvA8AuHyVrTf3aJsr+JC7FgnZUbSj/xRwX4+p69uPjdCKQt782w7bHNW+syiDaWwF2GAqGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewHgJGAmrqv1FJpXzuYR3L4m1RtF+CDAJjcddpSYiNU=;
 b=CXb609GGCcEZwQ6nHk4J2M+ZeXcw+VIz385EnbB0lWPTXIt1jZP0yNvy1R0KbkCM35IEnVO6rHB7vcxidpkLEZPo8/jX4G0qw6Ae49/9hJCoX0jbTSg5vQ/OqQNOlj79QGdTDQyDua6aGnvosdskGW/BioAAb7pNnXEHBVnoYF8qoUQXLficruzS+otKqVOWO6FtFvYygQlhb6BLOwXeR3EDBW+eecE0/qplxtvPsO4i+Q8tQURoY3ChE8ObJ9QoMPhJPWyz405BLY4NNbcCZSke/eeP+P69StOZPy9cwW1+vfsZP44BbPI5ZxVsya65ckNR+8cBJGMs4mGDRln9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewHgJGAmrqv1FJpXzuYR3L4m1RtF+CDAJjcddpSYiNU=;
 b=TqETr2ch2QqFcKRRUpkkaoFQbDtHrlP7enUGaBVNjr7nCjv1agBfEQ4EG/LhxCHd8VmGICqlqaHCP13CGxxgS6pTPP804pvApTrisqL6U7dYp0EI+1lhlDZUNQ3Zf2n6FIyOhcEcoBfmRXTtBfYOYBWEiv+smhT0WpMrIW0GdqPl3kXvZgt9lA0KllYevKv+X8tejKaeJ9m+USk5fqgHUsXQEGDvy9Xqo1nfSJhcCSKTuNHmShhDZUhKHy9GxyI0A9CZ5bDKw5zjOiMSGTmiuZMhlMsqTFPehL7P49h7I96r7reEM3Vi/bRLAY68Ual6mU7ibK5qiqpxJqz0njOr/Q==
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 23:27:36 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::f8) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 23:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 23:27:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 14 Jun 2023
 16:27:19 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 14 Jun
 2023 16:27:19 -0700
Message-ID: <8f3bb4a8-80cd-547e-df65-2d17827362f0@nvidia.com>
Date:   Wed, 14 Jun 2023 16:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: lib.mk: fix out-of-tree builds
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <usama.anjum@collabora.com>
References: <20230613074931.666966-1-anders.roxell@linaro.org>
 <928ad485-2dc2-2e02-98a2-fa203441f463@nvidia.com>
 <CADYN=9KtYe6jo+MDm+3NVwfNFzsOgoRRKxu_hSJeEPMuLRGgeg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CADYN=9KtYe6jo+MDm+3NVwfNFzsOgoRRKxu_hSJeEPMuLRGgeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: c22d91b0-fa10-4599-3627-08db6d2eeec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xUWJu3ZgD3ycBShRn1s6ie7fl7uemKfXD5ZEhxm7I87bs41Yy3s/QRuI9+1ZqJ52c6JDjGzn8WtRJT34KuNUef5yMb2BESbfcNYZUNVDevkxgFYFFMJN9+zEg//4Bb5FWqa67zS6oXNtZJUAxKrZ7t5FsTCR3A9faVR2feWbio+gyTWrJjl1NZkrElVm6paO9Agh57Oh4RUkwtbJtWP9AJ3H6GGOK9OkYOfK0/PaUUyQTwnllwRYV+K+foTanuY0x86+0VqGG366vUEe7O0IH6bMfyg27lBOGTFo83sI3ms6+hOB18Uqu8cQcIZv6t+A4ZyjhxBm8oBSvqrK2jvkWt9yCcMi4CR2HQAhEbXT2Z1Zcjbj1bo6FQYC15bjFTEwYdHjudfbMiJj3PV2iBQyMo8PFJLMJxS1v62A6W/EuJOFEvfkII57xwPRtUrD/Wx0jvUqp7PGDBPDUKbTGyOspHxTBrFurLG/Jh43YBkC8rqNleor4QVQRUkHBUItXIemEWUnmyu4UAgp1WoweS5GZ47sKP3FPP4J9JT0BIbdYOtJrCVWX0N2mDfEXCruP9geRzpfGBzSmXubUZRYviX4EFVTxONOUBzisYhHotGaWkTIdeyKBt92nV6oq667WbEmPw3H0zahPpyO+arfAolH6V9MRJMe+rfl+ZYT9xhjWvoR+SiSQX4ehsNbsFubva9KFBErzkNAg8T82VGK9Cik9EaE1RD6ZcTjA4+HoJSxUy7lIaJQslS8uTnWvgjwQfUtexO54nGS1ju19EdARxLab7F9MITb5jT2eKs42FVNeQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(31696002)(40460700003)(36860700001)(8676002)(82310400005)(41300700001)(316002)(83380400001)(26005)(82740400003)(5660300002)(40480700001)(356005)(53546011)(7636003)(8936002)(36756003)(70586007)(336012)(54906003)(70206006)(4326008)(47076005)(478600001)(6916009)(16526019)(186003)(31686004)(426003)(2906002)(2616005)(16576012)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 23:27:34.3657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22d91b0-fa10-4599-3627-08db6d2eeec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/23 14:16, Anders Roxell wrote:
>> (It's too bad that we have all this duplication between the Makefile
>> and lib.mk.)
> 
> I agree, also the duplication of get_sys_includes in bpf, hid and net Makefile's
> Do you have any idea how we can remove the duplication?
> 

Well, since you asked... :)

Yes. Given that the goal is to support two similar, related activities:
	a) make -C tools/testing/selftests
	b) make -C tools/testing/selftests/<subtest>

, we could move common functionality into common_vars.mk and
common_targets.mk, and include those from both the top level
tools/testing/selftests/Makefile, and the subtest Makefiles.

This allows deduplication in a fairly safe sort of way, because it also
simultaneously moves everything to a non-recursive Make design. That's
especially nice, because then dependencies work reliably, and you also
don't have to worry about propagating Make variables (via Make's export
directive).

I haven't done this, because a few years ago I somehow got the vague
impression that it would not be well-received. But maybe that's
pessimistic and/or obsolete--times change, after all!

***************************************************************
Contents of tools/testing/selftests/Makefile:

include common_vars.mk

include alsa/alsa.mk
include amd-pstate/amd-pstate.mk
include arm64/arm64.mk
...etc, there are 100+ subdirs

include common_targets.mk

(This is instead of doing "TARGETS += xxx" in the Makefile. Including
the subtest *.mk fragments allows each subtest to add features and
quirks as necessary, while also enabling full dependency checking via a
true non-recursive Make.)

***************************************************************
Contents of tools/testing/selftests/common_targets.mk:

all: kernel_headers
     ...

Other rules/targets here.

***************************************************************
Contents of tools/testing/selftests/common_vars.mk:

Common variables, some of which may be overridden by a Makefile.

***************************************************************

Using alsa as an example of a subtest:

***************************************************************
Contents of tools/testing/selftests/alsa/alsa.mk:
TARGETS += alsa

TEST* items

Plus: alsa-specific items, such as:
CFLAGS += $(shell pkg-config --cflags alsa)

***************************************************************
Contents of tools/testing/selftests/alsa/Makefile:

include ../common_vars.mk
include alsa.mk

...maybe very little else needs to go here.

include ../common_targets.mk


thanks,
-- 
John Hubbard
NVIDIA

