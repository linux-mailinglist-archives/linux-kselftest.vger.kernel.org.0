Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F676CB13
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHBKje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHBKjP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 06:39:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3E3C3C;
        Wed,  2 Aug 2023 03:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR/UjfoLdx4LBVF9zpQWKVVYi4EtNyZf51ogLUrv8Bedc9zN2o9//3gyTtEajLtUTfZ4pKbrUvY0aycnNwWFjU/Bb8er++BnJBschpmqYEZChnoKdhvUudlUriB/MFWPGBkueXeoh4HJzW6y68xUSuFwJS7C/W5vlT1/pnGbi77YuTp3oVqBo7hyVcQVfVAYWkpbMPaIMytF0LpILIpIedhgn67GypVKabCU6i9wcxXXyTlmblU9fnWxX/vRGHsZqZeDrOVwj9kFFxCzTTRFuxkeMM/yK3L7XU5AF2bmPXr/8WoDk00xwXDTMIBtsVPbv3wo2DVUQ3hyAxFZiQkBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGhYpruplPF195TFVfvabAWZnSrETWnGzoh5M+JMsYY=;
 b=JxlDrtQaPx5hm3NRlzaz/DJk92ZKuvsM/rSvvrP6/raPsFTjPBCWTiwfoKDW/FLCaonoJRgA4utpnSan4zijTrs6MsuEB925Dvv8PoqLbQ7vCNV1fjgUaO+/ufHxcM9L9ElZ2fYFPWntaGWrE7EhyYMBKREFXtXNDUgshKT7ToAmq9WhYd4m37P9b7IpzvKBwuDbAlWMHQqveejxQaX4trFdmPCOtXP0kENxgaavIIZwcYdqbIqD8U/XrGX8Au0YKP7EmCrCTVXOvexZSvVe3U7iheye8lxWEnh5JbZdIO5Sa63eb7AWnk5xpCJ+IbRDLl/4gcCUhznwVNk7A6d8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGhYpruplPF195TFVfvabAWZnSrETWnGzoh5M+JMsYY=;
 b=ojJoKI0CSNtOXhekf44SK07hTdavEe0xx0x83scON/dNkafWzcUI+XYT7EnWVu0TdE4zvX33AMtW3/nbvz1bra7m1i5nwHmAwYF/uAzLYhCKpa7RJON4ezFyX9sJL9+qr7FWwGeddo9Ol9ED7+VYV7El5FM+hc2pbPbCYidelx9VdfbVLrKh1h4O8LQVTeaV/KmK6EsD11RvpGvZsl2MT7uS5eEdx9fphe1skVjX4WB0g4M+54EjCjK9uXOQp1NfEjVQD1tJEJudcI5Sil808BjPCKaKQ+K9SOjMI5vnsnTSGXxEtfJdaWgL/jrIrnooTvMYBcNHq6mz7RfxrQ4JVw==
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 10:36:07 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::d) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 10:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 10:36:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 03:35:50 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 03:35:46 -0700
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder> <875y5zf27p.fsf@nvidia.com>
 <304ba960-0214-82d4-05be-e5956baa64c7@alu.unizg.hr>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
CC:     Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@idosch.org>,
        <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Wed, 2 Aug 2023 12:33:37 +0200
In-Reply-To: <304ba960-0214-82d4-05be-e5956baa64c7@alu.unizg.hr>
Message-ID: <87o7jpenpd.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6c6e34-8131-47e6-9e6d-08db93444790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fqf7Ut4D4C6jit1PxHxF5qvI5T4mwICcAUXyvXmnhycvBKjNGfWs52qA5i7WkrD990jCKTbE96kP1BwbFF0dRhauFiLV7zeg6kMmqgJue2epYXdWfAxG8uVoAHTccO6bn1cLkTpyI3p10GoKs5H1iRZwhf/hN8A4/gLH7XWNe83/Uaj4/b4Pcg5ugleu8nnrHxvwZrmCm6KO+DKgiEnSbVm+hjAdnhuVm1FlGIqLvtVcAPWA64wlKUZIrS51enOvlC7CCEKusRxUWbvLm0XP4uKfmKlwVek8CCd0PFtoYw92ewAEj5KGMTHdwWZzinAOnAg9R5acR0o1mDKTjQ47ORaW/WssvTRPgKgvpAaKj9EbYQVEhk73qzmUaamqhmPXAMRbPC96mgtKa67Ysak5b81MsVnUU9xt/5UjiS6nGb5Yw/yoN6QKVJlx1kgO79eDDJEeZnRbwlQinB6b6n4XoIRs0qbuQG3VUb7MgszsRIQKtDCFI02RBG26rHdrbMYKqKmwwrC6L4VHMJkaRsVaPoTiXh5dQGI7TpcmaZVc/Vs03PuCY5xPqFYgV715dE6CEB78yWIvqIrTe9GxyuwaNsqWK7yOPfIHlLYDq/dftHDVWxWKumEkCMOsOpuUng889sxgdCHvXRiFu4wwD7Oh/7ahVT0eYit5SvuQHWjgciZs7FSb8boVDeHHjNdFP2hFUiH0BSeMx8to1ZYCGnB62+XTwti3PZqMk4Y+JcAk67kwncIgsd1/MCHl9UVoDRS
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(7416002)(8676002)(5660300002)(36860700001)(426003)(47076005)(82740400003)(83380400001)(2616005)(7636003)(356005)(41300700001)(316002)(336012)(186003)(8936002)(16526019)(53546011)(26005)(4326008)(6916009)(86362001)(70206006)(70586007)(2906002)(6666004)(40460700003)(36756003)(478600001)(54906003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 10:36:06.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6c6e34-8131-47e6-9e6d-08db93444790
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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

> On 8/1/23 13:08, Petr Machata wrote:
>> diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>> b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>> index aff88f78e339..5ea9d63915f7 100755
>> --- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>> +++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>> @@ -72,7 +72,8 @@ test_span_gre_ttl()
>>     	RET=0
>>   -	mirror_install $swp1 ingress $tundev "matchall $tcflags"
>> +	mirror_install $swp1 ingress $tundev \
>> +		"prot ip flower $tcflags ip_prot icmp"
>>   	tc filter add dev $h3 ingress pref 77 prot $prot \
>>   		flower skip_hw ip_ttl 50 action pass
>>   
>
> The problem seems to be fixed in the test run:
>
> root@defiant:tools/testing/selftests/net/forwarding# ./mirror_gre_changes.sh
> TEST: mirror to gretap: TTL change (skip_hw)                        [ OK ]
> TEST: mirror to ip6gretap: TTL change (skip_hw)                     [ OK ]
> TEST: mirror to gretap: tunnel down/up (skip_hw)                    [ OK ]
> TEST: mirror to ip6gretap: tunnel down/up (skip_hw)                 [ OK ]
> TEST: mirror to gretap: egress down/up (skip_hw)                    [ OK ]
> TEST: mirror to ip6gretap: egress down/up (skip_hw)                 [ OK ]
> TEST: mirror to gretap: remote address change (skip_hw)             [ OK ]
> TEST: mirror to ip6gretap: remote address change (skip_hw)          [ OK ]
> TEST: mirror to gretap: tunnel deleted (skip_hw)                    [ OK ]
> TEST: mirror to ip6gretap: tunnel deleted (skip_hw)                 [ OK ]
> TEST: mirror to gretap: underlay route removal (skip_hw)            [ OK ]
> TEST: mirror to ip6gretap: underlay route removal (skip_hw)         [ OK ]
> WARN: Could not test offloaded functionality
> root@defiant:tools/testing/selftests/net/forwarding#

OK, I'll add your Tested-by, let it pass through our regression and send
upstream.
