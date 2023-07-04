Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9866C746EAB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGDKbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDKbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 06:31:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5B135;
        Tue,  4 Jul 2023 03:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owv4yTsdDdXVUkGLtPEYCg48QKy3eQ62+Dfm4f1/+LdLbtIS0YjQTiDMODhyQIyJhpaqupvahtCWvGa7Y0GZO9kbWh6cbSBF6fLLo2LZjziO41K7r13pINfDKjKDD4d+ACzweNKt15QSUnPcmijM3i1jVGdTS9rjFvqikC15mpwtZAuhdff7oVnDY+zurk2N6HUKiWPBJ5c6/Ri7KR1/xqcuPhE5endYFLOLWeh2LM8cK+m7nE6uyiGGL1wgyF1N9vq996/oCJVbGO07+Hd+WeS703zcjexKZiMqAqbVtcgThsVvVUW29uellD0S2zwuxm+D2gCR5dG6YLwmTRjIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6Ki/oDE73OM2g24kGgjiV8glv9v3VhsD3MghY96r4M=;
 b=INegiR0LQ8IdzHvw3dcLM1XHmQwiQjgsgvkPd6ik9ihEyZsPXKK03jB+Cp129PXhHqAZs25jBWL1a+fIudiYXpqGwMHce0dwWX3Yde82jaL2+HY6K4KtN9uqJHOgtQu5yxrVL92J5oEdPclWUef5rJtmlua6++OgxQkoLOU+/hddCnhqMwGRDWuo2VHgQQZ/Sc7ur+0/1DLykVCLzhl4/QE4WoXmwjH7D7uxhtdWyPvtkBsRt1xojYtmRz8Wfmbg5mv0qB61ZWY/NeMSoP/vTxWydcxKWZZOPucddYYiRu4nZ3H9ZE7xZkBLYAlFAGYm9BVCM/Ci7pNRBy4Ki09XIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6Ki/oDE73OM2g24kGgjiV8glv9v3VhsD3MghY96r4M=;
 b=HS4CN+3utxELqT81Gc0WRXIc6jITo6UP4avHd3xPYFQQEpXcSC8uHjBUU4lQbDhNbg0Ujo8QLY/k4aOWL2DArUq2tiaAa5EtB2i0HjGepRqFfGeysSztmHUnTDiPk76kCrMpbz4HzspC7frZs1t1rEP3L5jULR6Cf9keWDY6X2C6XSVcnjrf9RgqsIraZYs0489IKePThsLK43Tbfmn886ZR9xLhdN7TpRjXmPisPrC7pHEztt11ws0ihUK/ePhZzuCkkBBcRjFEdw9FWYkirQsH4mz6lzSKp0nXKfjReQRZtHOk1aR+pFegtQJ39PoELVQ1pNeY2G1jjelXK7C+qA==
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:31:04 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::d4) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 4 Jul 2023 10:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 10:31:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Jul 2023
 03:30:53 -0700
Received: from [172.27.1.49] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 4 Jul 2023
 03:30:47 -0700
Message-ID: <5621fe4a-5c21-b407-91a1-4cc299f5abb0@nvidia.com>
Date:   Tue, 4 Jul 2023 13:30:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Linux Memory Management List <linux-mm@kvack.org>,
        <kunit-dev@googlegroups.com>, <kvmarm@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <202307032309.v4K1IBoR-lkp@intel.com>
From:   Shay Drory <shayd@nvidia.com>
In-Reply-To: <202307032309.v4K1IBoR-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e39ff4d-e360-4728-e8d7-08db7c79c4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dg1qCc2ry6ECA1DeFK0AJNkukvr5SGvJUuu2Rc/EXg/nkPf1U6wqU8GA3nNoha245s/tZ4H9sB+ynensGCbCTW7vQQRrmpovDizSt8fig3pTU3prn2qxQnv1NxY2LvPwSFPWs7tqJvFqFlOmPejF7sn3jX3GpzFPxXaNZeaZN5oFuDa6KAF3xD6Wzk61XVgjICVN3Fk74W4SWQTFyB+DycJTK79YGKjHxZZQZ313TOSeI9WGkIyCkKcGmqaFgo7SO1kKJTBwXCDKWONm6+rz/DNvKIaG0tASDCj4+Ia01ZpyyB1DTboQJnLuBPMvlDElWeFeQPJ9gpC5B1QgAN5UFSig0HCPKWKXmR1uPGroeyKn+sHTL/qzT21zY46prAfPemcmyJZoDpnMZMulhsPJtErnW5ofKTkQSrMRlkeZbYQV3AXLz/4R8BdLMmLqBtiC16h7WuDajf98C+go4ExFMa6dVGbAjJ/yw7RXa/n+sCw26z3N9p8T2/wf7lxIQFvoDrF1hodAaA2GVz6UTHYMew4SbKRbXX/VkRYToUO5q6DhKhF2tkyiHtBTvSn4R+7JWDQ9aimDD/xsnBuPiaAh9vh6jDKgTReBm4phdBMaJ02xiG5qnIsV5JJJt0giv2HblD0ocQ+UBJeit/JKmDXPn37M6qICNo4K4/H5D41w9qsULAerbp1WAkfqTadJSvPUNlGrtmbXdOEMawhAHam/xplHW2taeQoO+aXSCgWFV+TNlSgXRWfMP0oj6j9DUuCfJhPicOwkKBiqOC5zu31Oyv5JYVmJhJDQqB8mvJXYMAe/HIJoTIgCky7SAcoVu+0
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(16526019)(186003)(966005)(31686004)(478600001)(4744005)(7416002)(26005)(5660300002)(47076005)(36756003)(2906002)(2616005)(86362001)(83380400001)(336012)(82310400005)(31696002)(426003)(82740400003)(36860700001)(70586007)(4326008)(7636003)(70206006)(316002)(8936002)(16576012)(110136005)(54906003)(41300700001)(356005)(8676002)(40480700001)(53546011)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:31:03.6023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e39ff4d-e360-4728-e8d7-08db7c79c4c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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


On 03/07/2023 18:11, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next specific files for 20230703


[...]

> Unverified Error/Warning (likely false positive, please contact us if interested):
>
> drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.


This *is* a false positive. there is a comment explaining it.

