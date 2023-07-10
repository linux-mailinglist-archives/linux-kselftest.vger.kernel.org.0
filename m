Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4851974E209
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGJXKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 19:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGJXK3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 19:10:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35010D;
        Mon, 10 Jul 2023 16:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2YyFsV8wJMFhQcbZyLjdgclrZqEdInK2VyMbZnq2QdKtiVFVEPFn18JcSwf8lr8X4msp8LLG464j+P7cijf3zEzrHUHA+SGCcrJpRLmBKXRD45jJGvySqi0bixs31uucYp5b3nMfvD/4UeAEdnoCaFiWlmVAbzOHQfBiQlv/GqNgQ5roMgpXhR8v7f27TprdggZlE5MmVUqrRBue6TQrCDg6JjhV2GE1VcK4DIbAzArp1o1aJuuOJiDj6y15jpqYYANd7gF6kOmJ1+jGQHN6BRTlHDt815ZkAg7NIUbg83+TV4mO4VtHD8Ex5KJZPeyf0m+dqQJAEbPWjDvcHH5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT1wTKrFhcOh6CayGFBZ6HHRbxAACABT0b14NjzSs1E=;
 b=UvnPsuET1lYnWCBATMzFPNz1dKzb75Y0CACQq554CYHi3Nhz69/pN93D6fUxnpG6i70y7LxwCVbpYkzfXGxhqED5NJnP6ykTzaP9wOLGBnjGXrztNZP5QpE0sv+Y649cxJr8wBVbbImCXZt4aFWFvLjTrcek56gGWeFdUGIyAWpyOwzeg4A4yihnMJ5MwIPuUR8ED6P9MPemhY1vOkjb1Pjbz0xzOSEc6PGh478M5WZm4IuVwpPFFVSO/2Oj06FhUrZy/IAL3ZSIcbp1qUBXAlaBy+azgSOaAmmcWCLCPR72d/CG3dkNYo7lUy6TAm8Mi0a7e5ZXoTGTQSrP1aIbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT1wTKrFhcOh6CayGFBZ6HHRbxAACABT0b14NjzSs1E=;
 b=WuxdR2JlHcBGuMd+rPX/YpTvImZ/f72Q/K7wXOga7gp9AsY9MwWC3+hdasySuwgmdlAiNH68Nds3LvyJQQyXoso1qFgsxDJJdGqZ0dQ8DV3mRoUhr/XBASGVI37q3L/Wt/CDOSa944lctGV3jo+Q4Weqll3PgWlmaMSkzbgQMWcohjpxFc7kCnashN5tQ1WHcKjGESPJVGIg3fwK8Aq27UD2vVMtXnU+dXYQHCaBS2mT5LKngs7Uo3GJ2OQr/IZLGuudo60W57JbzZs4VvBYLeReRqHsgDxF7VwB/3958Lomfp9e+02e2T6W4mNLSKn1zSpczdu+v/lKluEmekun6Q==
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 23:10:25 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::17) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.19 via Frontend
 Transport; Mon, 10 Jul 2023 23:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 23:10:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 16:10:15 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 16:10:14 -0700
Message-ID: <04724b21-6c7c-8584-fd17-9222051dc99d@nvidia.com>
Date:   Mon, 10 Jul 2023 16:10:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
 <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
 <ec86c0eb-5c6d-48a2-c216-ec4f40710ca1@nvidia.com>
 <ZKyGh8AKRLobQKlX@finisterre.sirena.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZKyGh8AKRLobQKlX@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: cc97afd6-4f8a-4413-6746-08db819ad807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7H57mBCc+3k313ZQStnypmHm+KLaw4egIY+OKwsV6OOVw9ttuMP0QL3CQEaHPuzKRazodiJXRMEBTJOFhQXx3MmxiY1aX7eX18BMKRdzsHSzZh7Yt22xNDbLX5bflWrNYjVktJ6p8zb8PsJ2m4Nj3gjY4tPX0z8GtdNMZOMKDiLIsWiJ1Jd2mEUxthkwvvAitNW1xGvjSRU0e0wJ6n1fbjoSdq4MaHG8xpEW6EiewL4c978zbtSn/v2IB+KjexCv+uxFr0SU6JGR6b5spvD+k6POGYIF1J3tH/qyYNDZ92jEQ+ma0cIQstqFj6ARfW1Sr9XwsEgLYZrxBIONDOd4UXEwiqdHj/ZtdaJyJnJqh46+fdaXD0woJOd3zCnSQZKQS9QUsuLOxfS+V8FL1LMawB6ZKOfIU4bUXEeBicxLVxE07hl4cutD1bHPvukSFmQ2s89BQmA8VBDF9idaYAiQJyMOy7xakSAG4gWV+k0WLQPRGqVTIdkaIUUYaV4bY+IcyRoZokXz9Rq0dyT1uapBJgezk128YJK8u6t0T+VLkm/tBalD6u1RgiipGLcWPG/pBQo//f9uqfGN6NlEyOnNRBB0qnZfE+sleeZMTbTl/qoj1cr3uKpgbR5+12zBrGm+FZ3+EUyGFCEgqV3FZkit+aL+YaOPvGdQYpOLKXNIKheE7rYahj5teK3b5Lkp4hMI/HXqI+hB0cpt/wIe9XvJyyX3FtL4zBDwaIfZxDaK2N52SQfZGpKkSF5SovK7hoPqv+7gxTIWfxEEe8/Ls09YDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(31696002)(31686004)(5660300002)(8936002)(8676002)(41300700001)(316002)(82310400005)(2906002)(6916009)(4326008)(70586007)(70206006)(356005)(7636003)(82740400003)(54906003)(16576012)(83380400001)(478600001)(36860700001)(26005)(16526019)(186003)(2616005)(47076005)(36756003)(40460700003)(40480700001)(53546011)(336012)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 23:10:25.0805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc97afd6-4f8a-4413-6746-08db819ad807
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 15:30, Mark Brown wrote:
...
> There is a floor on binutils version for the kselftests that's more
> aggressive than that for the kernel itself, though that looks like RHEL
> 8 which has binutils 2.30 which *should* be fine for most things - the
> MTE tests won't build but they do have version detection so should skip,
> I guess you might have trouble with PAC support which doesn't have
> detection in the tests?  It's certainly old enough that I'm surprised to
> hear someone doing development for anything current with it.

This used to be a development machine, but now it is sufficiently old
that it is lightly used--that would explain how I could reserve it on
short notice for this. Maybe I'll adopt it and upgrade to a modern
distro, now that I seem to need an arm64 box.

> 
> I just tried a Debian based GCC 8 container which seems pretty happy
> for arm64, the command was:
> 
> make -j16 O=/tmp/out INSTALL_PATH=/tmp/kselftest \
> 	ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
> 	CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> 
> (the compat toolchain isn't used here IIRC).  It does skip the MTE tests
> but otherwise isn't showing any obvious issues in the arm64 tests.
> 

Thank you for providing a snapshot of what it looks like on gcc 8
over there.

OK, so actually, many of the failures were due to the "all" target
getting run too early (recursive make, again, uggh). With the fix below,
there are still a dozen failures in selftests, but only one in the arm64
tree, after all.

...
> That does seem to work around the issue at least with a quick out of
> tree build, including with GCC 8.

Great news! That's really helpful. And in fact, I have discovered two
more things:

1) The "emit_tests" target is there apparently because commit
313a4db7f3387 ("kselftest: arm64: extend toplevel skeleton Makefile")
believed that it was necessary to skip emitting tests if not on the
right native platform. I'm tempted to delete the entire emit_tests
target in both arm64 and riscv selftests (and that also seems to work
just fine) in order to simplify things, perhaps as a follow up step.

For now I'll just post the simpler fix, though.

2) riscv has copied this Makefile subtest technique to its (very small
so far) set of selftests. I have no native system to test any fixes on,
but I'm probably going to post a "blind" fix for that one, too.


thanks,
-- 
John Hubbard
NVIDIA

