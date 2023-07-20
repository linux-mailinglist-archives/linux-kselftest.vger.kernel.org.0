Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAD75AB93
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGTKAW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjGTKAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 06:00:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A54ED;
        Thu, 20 Jul 2023 03:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv4d8S2hsGwUu91eD1a3AYXVYp2V+KbTyHT4YJGVHLu0jowOXg+eKSkMUJhyvQl5uB0syaYsmYQE8qn4v06GIBZYzvNEZZycOF3fgBs8jKSeupYJmlpjBfG3eyu36+lk3VreLIjI0UGQxMIcr7NcVSALKCaU6Dw+6Sj7wks17OpGt/CdfFdBqEVCjr4HKMrp52nX3xLnBTJD+1bFBTzFDBm+yq++TRoRPEiCQ8+/wSiDX9aenbxJEGK9C3jWUTz8xos2G9s40yu5tLSKMpSiITHMDVq6HaJKolFfr+ezEjOOPpLA3dHcnNnFStIxoDWDBrmZVq2WBTd6vf/VWJ/EoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZVYTtLQzoVhZgX3JBXnNFLor5nC7WRuUJfDIjiZ7xw=;
 b=kvQH+VUjt3kGUeGfB2ySjUMRnoFCAxvJXAIjfvDVEMbWoag5J8hoFLx5xijHJLRrYbJ5DN83v6fAFOVb7y4aBgkNneKvFGWSSt8Lueb3EyBhZqJS6qhGRUCUbkCihjmjSyyZuXt82JJpRxI5+YuzoHi+NXJRqMTLEZ1QX+YfN6towUI5EmlDKOBJL9b0dvZiZphkULfPV/SLhPkR0kpQoALoA5BFJZ86eGnoVXtVmu4UPe7TuWTdxWG+Ni4Gz56ELnusJPE3/HQm3F6I63HGmURO3KSSd4tm+8zhJGArCrWvc/W11HuQ1OOUdAb0lrXJA5/3cdBCfOhLb9cQHR36Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZVYTtLQzoVhZgX3JBXnNFLor5nC7WRuUJfDIjiZ7xw=;
 b=ErZm9FxAgrW37vEw4SbBU1XQRFG8mXoU0SF57VWvP7Q75+4eKbagTYz3lgQ00ltSGR1VrmTkttGbUh559wlPLQfm4JY/XDcBHtJDN5f8QFU3j17wO56yfNsfO0SZ4i77l3DWP9lxAYAHdKALnJwMTdv1174DqYw1dU4ctvQqxPobZL2aTL5ARw6Kr0OTTOs46vk1bkrmamOkMHuPxEWWokyXi3drioQQ6dGMf9Swn7iRMzveNvik0Cu6I14JppAT2ugB5usSJ/s8zM6gG8tvBfMzlr+4eX/vg1N3VO00JRiQEy0YblDT7O6CIyatEzUwJ5CJlrXANOPsmD37HJLe5A==
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 10:00:14 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::86) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 10:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 10:00:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 03:00:01 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 02:59:58 -0700
References: <759fe934-2e43-e9ff-8946-4fd579c09b05@alu.unizg.hr>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PROBLEM] seltests: net/forwarding/sch_ets.sh [HANG]
Date:   Thu, 20 Jul 2023 11:43:45 +0200
In-Reply-To: <759fe934-2e43-e9ff-8946-4fd579c09b05@alu.unizg.hr>
Message-ID: <87cz0m9a3n.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 8291cb39-7641-4ae3-03e7-08db89081d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHkFj46amgQ6gw0lnIRqsC1mrd8FBCUJ69hssrAniAwC1ePf+LnLO/LiEC37rKwWiAbR0pz6aPR4c4KoNxTj104rPufCa1Ihax2YFn+9ACq/jLrdrmfqozoFQG31irZXyaB1sUMBPwfQC4/t5qu1jlFV/SVOAdPnIp/FAFERwNra6hFv3pwL2CGiTta0qRclSZczDNx7z+ggXsE9KhJxK5ERcLIcHMZT5HbRZEKteyAOe4a/eKU8IQ7iXqFyGYdyJEhc+z+aCgg2HV7EuaG/4iWgmoSRe4psnDgwpBbo35vNyCJoKQeXwExfaMPMGn2U1VjG0gvNt8fIssWDNvVv2c51MUlOeWqXae9/d8Wwv4ZBRtr3a50v20w0kbNesA5q28RY+efJW+/qirq1wgBOd9Pys1ywRhUnqcnqXieY48gikMrg70QTq9ahYdb+UW9UpBLkEHF37V/JoHoskpLOWtOIwSichQcQELWjHnyXBpr4R1bprtt9vYKiPkz33b2F0EHRkVnOVFKB0YIAoGc7YdLbKJlMUv6v0GmHF3+fVvnEzzxxgiIo9LIVV4f6CeDm7bMwD3ZfN8dv56r3Qi2LCAL3T3U9WKrEvXukVjIIlEU7ydL3hI12DnhOYMDR4sjvLA6p4C8STax0HSY385qKc3CPZ9fyBmMzqn/OFTzH6DdUHxrH0LqiY26XLUphfGAoSE3FgegDFj+0XOQFqxip9eNLe1T5Jnw8GdokZBq4lMduSb0Ocu6N5vtkcWL1BVFq
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(8676002)(8936002)(5660300002)(316002)(41300700001)(6916009)(70206006)(4326008)(70586007)(107886003)(54906003)(478600001)(2906002)(6666004)(40460700003)(7636003)(82740400003)(356005)(40480700001)(26005)(186003)(2616005)(426003)(36860700001)(336012)(47076005)(36756003)(16526019)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 10:00:14.0637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8291cb39-7641-4ae3-03e7-08db89081d05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:

> Using the same config for 6.5-rc2 on Ubuntu 22.04 LTS and 22.10, the execution
> stop at the exact same line on both boxes (os I reckon it is more than an
> accident):
>
> # selftests: net/forwarding: sch_ets.sh
> # TEST: ping vlan 10                                                  [ OK ]
> # TEST: ping vlan 11                                                  [ OK ]
> # TEST: ping vlan 12                                                  [ OK ]
> # Running in priomap mode
> # Testing ets bands 3 strict 3, streams 0 1
> # TEST: band 0                                                        [ OK ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ OK ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 3 strict 3, streams 1 2
> # TEST: band 1                                                        [ OK ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 2                                                        [ OK ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
> # TEST: band 0                                                        [ OK ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ OK ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
> # TEST: bands 1:2                                                     [ OK ]
> # INFO: Expected ratio 2.00 Measured ratio 1.99
> # Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
> # TEST: bands 0:1                                                     [ OK ]
> # INFO: Expected ratio 1.00 Measured ratio .99
> # TEST: bands 0:2                                                     [ OK ]
> # INFO: Expected ratio 1.00 Measured ratio 1.00
> # Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
> # TEST: bands 0:1                                                     [ OK ]
> # INFO: Expected ratio 1.42 Measured ratio 1.42
> # TEST: bands 0:2                                                     [ OK ]
> # INFO: Expected ratio 3.33 Measured ratio 3.33
> # Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
> # TEST: bands 0:1                                                     [ OK ]
> # INFO: Expected ratio 1.60 Measured ratio 1.59
> # TEST: bands 0:2                                                     [ OK ]
> # INFO: Expected ratio 3.33 Measured ratio 3.33
> # Testing ets bands 2 quanta 5000 2500, streams 0 1
> # TEST: bands 0:1                                                     [ OK ]
> # INFO: Expected ratio 2.00 Measured ratio 1.99
> # Running in classifier mode
> # Testing ets bands 3 strict 3, streams 0 1
> # TEST: band 0                                                        [ OK ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ OK ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 3 strict 3, streams 1 2
> # TEST: band 1                                                        [ OK ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 2                                                        [ OK ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>
> I tried to run 'set -x' enabled version standalone, but that one finished
> correctly (?).
>
> It could be something previous scripts left, but right now I don't have a clue.
> I can attempt to rerun all tests with sch_ets.sh bash 'set -x' enabled later today.

If you run it standalone without set -x, does it finish as well? That
would imply that the reproducer needs to include the previous tests as
well.

It looks like the test is stuck in ets_test_mixed in classifier_mode.
A way to run just this test would be:

    TESTS="classifier_mode ets_test_mixed" ./sch_ets.sh

Looking at the code, the only place that I can see that waits on
anything is the "{ kill %% && wait %%; } 2>/dev/null" line in
stop_traffic() (in lib.sh). Maybe something like this would let
us see if that's the case:

modified   tools/testing/selftests/net/forwarding/lib.sh
@@ -1468,8 +1470,10 @@ start_tcp_traffic()
 
 stop_traffic()
 {
+	echo killing MZ
 	# Suppress noise from killing mausezahn.
 	{ kill %% && wait %%; } 2>/dev/null
+	echo killed MZ
 }
