Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27633760DA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGYIxk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjGYIxB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:53:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5A1BE7;
        Tue, 25 Jul 2023 01:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZDld2brxHcLrx2y1DGTp0MEfdKkimkfgXC2yRwshNAJASPt4IjBQ3GgqKRInJ1TVUE4tXaWmf7pcdFNDuAUq4QgUPEGzcB+Jd8psYa7DJ2KzQ2wqEGzcgbXkjykIQdN53qVHR2NTENPBRIX6RmPnfuXIXCHpirQe7nbDUI2TYm0lQnvLb+DJlFOkf9H3vnlw43YwkZjJLV+kXhcIoL5M3hdl+wQPFNSOx+n9+du2i9unR6nfOwQ9E3M9E6NaP2Xm2nw8Mdk0uJmz2i2Ue0M1O6XBOqSzkAlAc8o+uq8LglAnrTkRrO6wBYGL4VeQ5k22xTiISeOI43y2l61fVI4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gKSAiY1bGs3nXMEwpyPOIpjSjSiKcJQypxfG6IaXoE=;
 b=XigGxuV5PZeAqX4t29q4gzPs9UZ8T5ZZbD0uT4ETnGIhfelIl8u0Bp8xo/qldSUNqkdLxhLJvF9MlLUZHG7MXlV/vMqG8w3io2XWvwfy/SUt2nsOPLkDkKpztzMontdTjGD1Tb8OKbYKcU7dfxwQtoejvgZsWugqlYv96W5SKNh/Py4PAvmF3zWPeHkejJjo7B6KEJ89UKZ+ylTSv4EjaobzwjIFXgOPQ8q9IKkH5tst0BEVAhYVxQlk9+dBxkw1ovgAsreb7sBqhZPxgYCvcIgYrphKCtnHqXXg1dK1fa5CaoZSWr64WiogCYJjfAzNc6svgzFaUPXWnTtZt6bTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKSAiY1bGs3nXMEwpyPOIpjSjSiKcJQypxfG6IaXoE=;
 b=pppveTNmg9oaKvBXQtmD8SAfvU84BFVX8co0BkB3Uv3Hznj33kpsWa82/RHG7qbFcbRXeSze8L5gioF7lNCHNJR2HzNzIcurJQvNrUFlT46wQpCsRqFOEPTeUjqh1H64aGcWPgXusQnMvt6CFXO9z+9sCSYewVeg4p2QeggihkH0Cx9YAvWV4BgQLoOhc86NvvIsAS8G+MPg0sDdtyDQkwL4hxApUb/WRknkFKSyEDuvhiStbeJ5xVUYMOxHlvFAjtYoW1bxi9BIUMA1iu+FYOuoKgm3TV/Q8qQ8txdyLrioBCMG6QIy+wB+j9IaV1eDQpVcjdGmyq4CcRHyW6PNNg==
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:52:11 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 08:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 08:52:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 01:51:58 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 01:51:54 -0700
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
CC:     Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Tue, 25 Jul 2023 10:44:32 +0200
In-Reply-To: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
Message-ID: <87mszkjrvc.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: a9445389-4f29-472c-0f80-08db8cec6efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EC1X501cMoyzQaYAc9nVObPH+XxB0fHisAVwLYynI6cLFSnMlGby+3qmatbGfvv5ZMZ/wmQD3NfAHAcM0J6zHcuC08qbhqEbxaa/19lr3muPsLfO9n+iWMF4Fc4v89OYaFY7WCU7BHHKB5w/jzp727GzzWQFxTKmUPQZInViSmgm+Djuv2XDOw4SvLdhHuWhiTX0A9/oFG9IWfnd9DJEgVex+6mTAtS2Nhwndlr9rRL0zCX6jSLoJ1aGF6noX7z+1j4S3vMBs+6p5hIxnsDqQwkPzZYmecSGcPs4K9Em8XfgvuWhZW4XBz82S1MOWfnRrJs6fXEi/4wfMTVwhMq26vz6wMK0wMAeEsbdvse7EhWMrgTlKoXRaqA90i72smLctYZkDvj56cDxYhnRUVybFxkdZ3KEcuZW86hdZQqW/FpLmAwthwDgYQt9appnN8DCqwzgzi8CFaJH4iV78RFvZ7SU4iGh28u2Gznuab7NYID7DllMUQ34cjCu5cgg2smzU31WAOVSnQti30XQ92noSRpTWEwK1iMP0FmmUvONKjGmcdd3+drmfYnDZl9oJYqGRaQFzzAKTf0ni4eJlx7KmK4p9p0vKI2Zbga2m1Haltj1QhGjjTNTr0yy4wTNUCewzEQew8rRJlDORWPudWZiFR7WH9hee4YsO1KpXj/gacCZheizp130zqHJHx9ZWbr3AtMVX1x8o0d+cLP1N0cYfsbSjZYkcqy4noKexIR2azPazdOP577/ExumD7RBYRHP
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(54906003)(6666004)(478600001)(47076005)(186003)(336012)(2616005)(426003)(26005)(16526019)(2906002)(6916009)(316002)(70586007)(4326008)(70206006)(8676002)(5660300002)(8936002)(41300700001)(82740400003)(356005)(7636003)(86362001)(36756003)(40460700003)(83380400001)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:52:10.3143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9445389-4f29-472c-0f80-08db8cec6efb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:

> Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
> keyboard, for the test times out and leaves incoherent network stack.
>
> Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: netdev@vger.kernel.org
> ---
>  tools/testing/selftests/net/forwarding/custom_multipath_hash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> index 56eb83d1a3bd..c7ab883d2515 100755
> --- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> +++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
> @@ -363,7 +363,7 @@ custom_hash()
>  	custom_hash_v6
>  }
>  
> -trap cleanup EXIT
> +trap cleanup INT TERM EXIT
>  
>  setup_prepare
>  setup_wait

I believe the EXIT trap covers whatever the cause of the exit was, i.e.
INT and TERM are implicitly covered:

    $ vim tmp/x.sh
    $ cat tmp/x.sh
    foo() { date; }
    trap foo EXIT
    read -p Ready.
    $ bash tmp/x.sh
    Ready.^CTue Jul 25 10:44:20 AM CEST 2023

Also, the interrupt trap seems to prevent the exit actually:

    $ cat tmp/x.sh
    foo() { date; }
    trap foo INT TERM EXIT
    read -p Ready.
    [petr@yaviefel ~]$ bash tmp/x.sh 
    Ready.^CTue Jul 25 10:43:35 AM CEST 2023
    ^CTue Jul 25 10:43:35 AM CEST 2023
    ^CTue Jul 25 10:43:36 AM CEST 2023
    ^CTue Jul 25 10:43:36 AM CEST 2023

(I see the same when I kill -TERM the script.)

This would call cleanup, which would dismantle the configuration, but
then would happilly proceed in the script. I might be missing something,
but I don't see how this can work.
