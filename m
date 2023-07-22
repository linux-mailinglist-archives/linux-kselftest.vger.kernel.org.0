Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5175DC9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVMkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGVMkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:40:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33321FF9;
        Sat, 22 Jul 2023 05:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Ta15BcxTrGJw21sE65Ow7FoSk8kUX3JByO/q1Foz0rOQ8hnV8ZBoCm4sdzF+gQxAEMqrmBE5wzC6Wuydjf+INI9Wa2MlLx9e64dE9KbQ2bClN4rRSgGyNfL6siHs7kHwe5gezXsSjGyPFiU6gxq5TmqLqxpPejG0VykHmXI+0wIXg6ygdXfNHyu1zpY5fHidD28YaiGzxCNG5Ejyt0TbQof1jkOK58OFP4bIyjJZctyNs8UCp0xzGxWH/Fv6IWtydISOYf8rgdaHSEUu9irsohMUmjjuhKEiJfctrDBdTKxkkPGcMgNmZeOuY0yCCUOsVAqEW1QX9z8CXKLN/kWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3hqmXH7ARYr74l1DP7BtsOKn/dC2Q3OWX8NPjkgTiw=;
 b=HfKxHO8tmsXFOVXkeE43U0D/efyWVyPWQb03GeyVbnmqixkBwZvOBDT4eR8AklLog09BsKDtYR3/LuODjvVot+q4I0ZPC197UD9qXd7WOuSh1kCoa6TVVJWIQkHrBkSlAjNMuZ7nE3l0ndT2eRf97yKNaFgiutOajuB+Rn3D8dLgksaV8z5QRiDu2xi1XjIXQYFUV4qhuINb5dTBrYlj7yjxh6gaEV+LUJMCNV1pt+QJQan5twUH6LBjUhvWvPqST0FiqfkMv3tUd7vzyye5ME0ib/Q+z51zF3XF8WahBH1dTo0bGaf7xMnEcTH1vE5YCUuCYaXbWpUYPhz1YMwyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3hqmXH7ARYr74l1DP7BtsOKn/dC2Q3OWX8NPjkgTiw=;
 b=cZCHhJ40YbrekYoxpIqwnuRSoIzeErF6iC5k5XPHu0wvn5Y3ZFuJ69byJOQRwTenFpYDF+kA2jVmtYIB8TY+px8qpTdCPrIkPgDMua1nKUFF7VG+ObWu+eP+cFnjFRUt9WpP20o5kY25a1+9DgMIXKV77Tk1qH7xDVFBV6sLnDg76abaJBWFj+jBUYvOEKXyAUsXlOa9yOSyfnOIQeQOn5EJZQ2UO703mRcRpZyy/xibAaSSi6+1SjC1EfaPDdejJ5t3kFHmAnVUaGVMggq/GwBIQzTa1TlZNVPQ55MPlLExCaMp7uzOqIHCJWuutyePrax/fWBTIBJEbVsPlXMsNg==
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sat, 22 Jul
 2023 12:40:08 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 12:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 12:40:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 22 Jul 2023
 05:40:02 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 22 Jul
 2023 05:39:59 -0700
References: <759fe934-2e43-e9ff-8946-4fd579c09b05@alu.unizg.hr>
 <87cz0m9a3n.fsf@nvidia.com>
 <580b9f28-7a68-e618-b2d5-b8663386aa12@alu.unizg.hr>
 <6c871d89-390d-41ae-ef48-6cd12b99fd74@alu.unizg.hr>
 <c9a9856b-4a86-3f32-b6e5-d89af4a46048@alu.unizg.hr>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
CC:     Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PROBLEM] [ADDITIONAL DIAG] seltests: net/forwarding/sch_ets.sh
 [HANG]
Date:   Sat, 22 Jul 2023 14:29:32 +0200
In-Reply-To: <c9a9856b-4a86-3f32-b6e5-d89af4a46048@alu.unizg.hr>
Message-ID: <87351g6rxf.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5ae3c6-51bc-4d13-4360-08db8ab0c824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T599hcnUSOYCItONpWcDtu5RDZpc8pG3GEj5iVSEtb4YfHs87pdRYZaMkaYLXcjVEPiO1MBjHyj3lgdOP2TOyI8b5Djgl3bIKRqMEq8fHkVFmVBaL8CsufZLsM9cZw65/YFd3PAn6vpn/CgtPpPqDv2O3kgLIxGujCCSXKol6voui0pzwwRzyd/GL4DSn6TBEbTwmyk9bVMFhA38ndv45yewvpFBC0FIRU9Rc1Ibp2xag7HoyTgk3gJ5gsucVIwRH5GiMx1K5qe1PL0fPVFkPRRJc9jFqVLNjyDVgyjeIyGl1eKFLj1Ayi7CjRqeS2jfnVZ/ArkgvhOZf1J+d3qxHCTRoq09H/kXFMcnx9zy05DoDK8bUWJEK3ygnukrK4vfGwz2uaZvo45M6OKXtVi20Z6lc1PNUZlrpCeTCD60ely4RBXkpc2AhptqwX6y9v7I0iAwypWgApXb3gL8D83m9Ze/fM3i2209Ao765A4nb4H+qlT7RE/2Ma4wYrT7WGNZ26meft4+x2GabtFHYmzvv2BVkfoCFGt2ZYwnZLlEUX83ItU01Yw4usFUKgeNYGlxemjcqSAhZ4xVciY19wzTFUocId9DwuggNuz5cxT91m87b0Pyv3COD4ZVIzEwCwKKThj/IlBLSGroXVJrQRjZyH4MhRK1nC1mo3yJedLEtsqElmC6Oh8AhyBtDwD0l7YSFSsWlXBJ+8etgOrLRZh0J03YmaUteWBUabAR/lb9V1U8gB/ar6kfeQmesMomOlCT
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(356005)(40480700001)(40460700003)(7636003)(6666004)(82740400003)(54906003)(5660300002)(316002)(8936002)(8676002)(41300700001)(4326008)(478600001)(70206006)(6916009)(70586007)(36860700001)(83380400001)(336012)(16526019)(426003)(2616005)(186003)(47076005)(53546011)(107886003)(26005)(66574015)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:40:07.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5ae3c6-51bc-4d13-4360-08db8ab0c824
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:

> On 7/20/23 18:25, Mirsad Todorovac wrote:
>> On 7/20/23 18:07, Mirsad Todorovac wrote:
>>> root@defiant:/home/marvin/linux/kernel/linux_torvalds/tools/testing/sel=
ftests/net/forwarding#
>>>
>>>> That would imply that the reproducer needs to include the previous tes=
ts as
>>>> well.
>>>
>>> This is entirely possible, as timeouts and CTRL+C events do not seem to=
 be caught
>>> and the cleanup is not done ...
>>>
>>> sch_ets_core.sh:=C2=A0=C2=A0=C2=A0 trap cleanup EXIT
>>>
>>> Some tests time out even after settings:timeout=3D240, so IMHO this sho=
uld be taken into account.
>>>
>>> Best regards,
>>> Mirsad Todorovac
>>>
>>>> It looks like the test is stuck in ets_test_mixed in classifier_mode.
>>>> A way to run just this test would be:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 TESTS=3D"classifier_mode ets_test_mixed" ./sc=
h_ets.sh
>>>>
>>>> Looking at the code, the only place that I can see that waits on
>>>> anything is the "{ kill %% && wait %%; } 2>/dev/null" line in
>>>> stop_traffic() (in lib.sh). Maybe something like this would let
>>>> us see if that's the case:
>>>>
>>>> modified=C2=A0=C2=A0 tools/testing/selftests/net/forwarding/lib.sh
>>>> @@ -1468,8 +1470,10 @@ start_tcp_traffic()
>>>> =C2=A0 stop_traffic()
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 echo killing MZ
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Suppress noise from killing mausezahn.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { kill %% && wait %%; } 2>/dev/null
>>>> +=C2=A0=C2=A0=C2=A0 echo killed MZ
>>>> =C2=A0 }
>> FYI, this is the [incomplete] list of the tests that time out even after
>> being assigned long timeout of 240s instead of default.
>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep TIMEOUT
>> ../kselftest-6.5-rc2-net-forwarding-8.log
>> not ok 13 selftests: net/forwarding: custom_multipath_hash.sh # TIMEOUT =
240 seconds
>> not ok 18 selftests: net/forwarding: gre_custom_multipath_hash.sh # TIME=
OUT 240 seconds
>> not ok 19 selftests: net/forwarding: gre_inner_v4_multipath.sh # TIMEOUT=
 240 seconds
>> not ok 21 selftests: net/forwarding: gre_multipath_nh_res.sh # TIMEOUT 2=
40 seconds
>> not ok 22 selftests: net/forwarding: gre_multipath_nh.sh # TIMEOUT 240 s=
econds
>> not ok 27 selftests: net/forwarding: ip6gre_custom_multipath_hash.sh # T=
IMEOUT 240 seconds
>> not ok 34 selftests: net/forwarding: ip6gre_inner_v4_multipath.sh # TIME=
OUT 240 seconds
>> not ok 58 selftests: net/forwarding: no_forwarding.sh # TIMEOUT 240 seco=
nds
>> not ok 67 selftests: net/forwarding: router_mpath_nh_res.sh # TIMEOUT 24=
0 seconds
>> not ok 68 selftests: net/forwarding: router_mpath_nh.sh # TIMEOUT 240 se=
conds
>> not ok 70 selftests: net/forwarding: router_multipath.sh # TIMEOUT 240 s=
econds
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>
> The test seem to be stuck despite adding SIGTERM cleanup to all tests
> that timed out:
>
> # selftests: net/forwarding: sch_ets.sh
> # TEST: ping vlan 10                                                  [ O=
K ]
> # TEST: ping vlan 11                                                  [ O=
K ]
> # TEST: ping vlan 12                                                  [ O=
K ]
> # Running in priomap mode
> # Testing ets bands 3 strict 3, streams 0 1
> # TEST: band 0                                                        [ O=
K ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ O=
K ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 3 strict 3, streams 1 2
> # TEST: band 1                                                        [ O=
K ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 2                                                        [ O=
K ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
> # TEST: band 0                                                        [ O=
K ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ O=
K ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
> # TEST: bands 1:2                                                     [ O=
K ]
> # INFO: Expected ratio 2.00 Measured ratio 2.00
> # Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
> # TEST: bands 0:1                                                     [ O=
K ]
> # INFO: Expected ratio 1.00 Measured ratio .99
> # TEST: bands 0:2                                                     [ O=
K ]
> # INFO: Expected ratio 1.00 Measured ratio .99
> # Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
> # TEST: bands 0:1                                                     [ O=
K ]
> # INFO: Expected ratio 1.42 Measured ratio 1.42
> # TEST: bands 0:2                                                     [ O=
K ]
> # INFO: Expected ratio 3.33 Measured ratio 3.33
> # Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
> # TEST: bands 0:1                                                     [ O=
K ]
> # INFO: Expected ratio 1.60 Measured ratio 1.59
> # TEST: bands 0:2                                                     [ O=
K ]
> # INFO: Expected ratio 3.33 Measured ratio 3.33
> # Testing ets bands 2 quanta 5000 2500, streams 0 1
> # TEST: bands 0:1                                                     [ O=
K ]
> # INFO: Expected ratio 2.00 Measured ratio 1.99
> # Running in classifier mode
> # Testing ets bands 3 strict 3, streams 0 1
> # TEST: band 0                                                        [ O=
K ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 1                                                        [ O=
K ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 3 strict 3, streams 1 2
> # TEST: band 1                                                        [ O=
K ]
> # INFO: Expected ratio >95% Measured ratio 100.00
> # TEST: band 2                                                        [ O=
K ]
> # INFO: Expected ratio <5% Measured ratio 0
> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>
> What is happening is a stuck mousezahn loop:
>
> root      558266    2732  0 01:17 pts/2    00:00:23 mausezahn veth0.10 -p=
 8000 -A 192.0.2.1 -B 192.0.2.2 -c 0 -a own -b ba:33:37:81:dc:5
> root      558273    2732  0 01:17 pts/2    00:00:23 mausezahn veth0.11 -p=
 8000 -A 192.0.2.17 -B 192.0.2.18 -c 0 -a own -b ba:33:37:81:dc

Sure, the test is stuck and therefore didn't reap its MZ invocations.
The test is supposed to invoke stop_traffic(), which then does { kill %%
&& wait %%; }, which should do it.

The question is, does it reach that statement? If yes, the wait is
likely where it's stuck, but why? If not, where else could it be stuck?
I don't see any other place where the test loops endlessly or waits.

> I am not sure if this will ever complete, or is it a runaway loop?

It won't, that's what the "-c 0" on the command like does.

> Probably it is stuck, for nothing was written to the test log for 71 minu=
tes.
>
> I hope we are coming closer to the cause.
>
> Previously I didn't figure out what hanged.

The script did :)

The fact that there's mausezahn running alongside is relevant, but not
the cause.
