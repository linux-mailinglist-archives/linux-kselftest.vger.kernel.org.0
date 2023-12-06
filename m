Return-Path: <linux-kselftest+bounces-1281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AA806FD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2800281BE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935E364DD;
	Wed,  6 Dec 2023 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZ0qzKfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB4D3;
	Wed,  6 Dec 2023 04:36:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhRqWd5efRvTBJT8qEOw1czSCcx6ArNjVzz+yLf1rhf/WzhYoYq1S97Zt9YZilO026Vj5rCeaUc6Erf5zcYyFenddTTBX2cEFZ+URvaf2EpO6JYwBLdk2V4oXw54x08aZE1SwAohdrJjA5ulrbAYklzg6qa85fQ4znX3iH7tD47cyzpRNLULvIlMPwiFjDMwbkfDWrByJlLTZt5reaFnWY/69Bta7zPKV5L79YWOcW7iM82fjgnI1ls9P5ItoQC14QfF7dFKZ1CVuBY+xgPca6qQhNpifaswAFXcTfhSXqhtPTRrminIEK0DKirXLphqXf+DW9sgEX3vKBWckPTs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkgDOQ0mwVDJA0cyQFrP/FeI5Fgzr+viUh7dPsRrw3I=;
 b=K2fDLpan1YMAta2Afn+Uef8Y8HIP1fsxmZ7GlgYSha79Fi/2Y/I92iIT5GizwfsdvL+zezyEpUYWea1ZrcEfHBekbzEgpuGSNtIIdCBbVmfdM5+ryNSCf0Gb4hvcA5Ve61NE9ApXZPcDWYiRPM9FY80YkIB1B1NXjzvY7JMEf3V3ysUNZtk0PGnm/IVGlV5z+b6FZ3UHT7gGWonM0XwC7FCtK5hObUt1Ki5BRh8ng9pmPb0wpf+gljIj+qHcpZgACs0Dw2ZHIUIJZCS2UEC1fEyNOn4iPg2O0HzxZ2IBHMkAq0I0WqCYr2UxBAVDoaY5KZR+MbYztobzAYkelXMAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=katalix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkgDOQ0mwVDJA0cyQFrP/FeI5Fgzr+viUh7dPsRrw3I=;
 b=MZ0qzKfkzC9Jr9mX2KfzgmyLN18BkF97SvjNEsdxIgsN3HGh+qrAaDUS7JVX3fS3GinyTQrr0v/GsPx5gKJr1tbNDYcCjRvscBntOiQceu9k4vsXmKRolpDmK9vnW42ntIeeU1CTsTVowSr5AEUAz9loMuoyEyi/6erg/OI6sCop8aUCdMPrMPgmAFB4W06MzCM82rhYy4wsfPSKTwnfauCLPNMNlK7fyDX0VS5nXluKT2X7nwDXFh/28Oq+9ix4i2vUlQOlmrPcvhzwJsgOYQ/4ZflfB3k91BdgbUzqPwWZKaHuKjf4catGvhy0FKqjtab4Fc58MNK8mDX79KnMow==
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 12:35:57 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:610:50:cafe::95) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 12:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 12:35:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 04:35:39 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 04:35:35 -0800
References: <20231202020110.362433-1-liuhangbin@gmail.com>
 <20231202020110.362433-2-liuhangbin@gmail.com>
 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>, Po-Hsu Lin
	<po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>, "Petr
 Machata" <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>, "Jaehee
 Park" <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "Justin
 Iurman" <justin.iurman@uliege.be>, Xin Long <lucien.xin@gmail.com>, "James
 Chapman" <jchapman@katalix.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
Date: Wed, 6 Dec 2023 13:32:04 +0100
In-Reply-To: <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
Message-ID: <87jzpr5x0r.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 19022b3b-12d8-4aa0-4017-08dbf657e48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VOPH4jTQMS7jcjsmKEkqU/hIA8UCZfivemn0t4ZgOV+Ya0dPtpKh1F2Fwmqq5jHB9498NXEpbtulyANPNhntI0yhq4K0TFAomihQukKV8geXfhxG9+FNBnGV7hA02kyCNYMQKvm8XrM2kMFVpYXtKGjl6Lx3ILPD9DH07RSzAj4kul+f24XCj6cERihGb7CN80SP4tIlmmLPEo9zrysV2vedSLhkrcNK8IVwH3cm0Jv1qQfpOD3bkGt2Fdfy+BIA9MdW/+zzncwnayDE53YSEBrbHkxpY2fC94Y/4+RRkLcKoawvW0u85/ags7U0hy0xVSfn52mBA7sQHugcC89VazYp/WYvV6fX0GE8yhL2uysZ6/jM/a+LrhdtDK80f2RymjbGIMj/OyLBjYLi2hKYPi0ZEo9a9p+yHkrNDp3BWY5y/0Hp+PjLcCCbxzt8j+zdOJDXoXW71s8W7+C/mNxw5SbgQ5ExnIqLFW8kHEdkJQbFTyrFj2nCqeOWgfD+QRdcZXb5Ml/fUJpGqISFnV3dvsDN7ATxVBGagsmA0IXk6jgWDSGgQCKbKkoJlsOHdX+SVK94i69KL76c2ddA4ezVHYitZntVGU/iTciIDUVgrTXG0+GqUTX3OTKnK2li2YvhUioOf6MsKjYcC/w5O7TdMHY8Ua5+3FYmPcDwe2IeMSZgJoEF5UfCTOgTHgsefLCd9OztqOl7CFBhg0w4SALqwaPd0CbUrNiFbBO1eK9BxeoKZDVVpNZskz0fecJ3URei
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(70206006)(6916009)(8936002)(8676002)(4326008)(70586007)(54906003)(316002)(40480700001)(40460700003)(26005)(16526019)(41300700001)(2616005)(82740400003)(5660300002)(7416002)(2906002)(478600001)(7636003)(6666004)(86362001)(47076005)(36860700001)(83380400001)(356005)(336012)(426003)(36756003)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:35:55.8505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19022b3b-12d8-4aa0-4017-08dbf657e48a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064


Paolo Abeni <pabeni@redhat.com> writes:

> Side note for a possible follow-up: if you maintain $ns_list as global
> variable, and remove from such list the ns deleted by cleanup_ns, you
> could remove the cleanup trap from the individual test with something
> alike:
>
> final_cleanup_ns()
> {
> 	cleanup_ns $ns_list
> }
>
> trap final_cleanup_ns EXIT
>
> No respin needed for the above, could be a follow-up if agreed upon.

If you propose this for the library then I'm against it. The exit trap
is a global resource that the client scripts sometimes need to use as
well, to do topology teardowns or just general cleanups. So either the
library would have to provide APIs for cleanup management, or the trap
is for exclusive use by clients. The latter is IMHO simpler.

It also puts the cleanups at the same place where the acquisition is
prompted: the client allocates the NS, the client should prompt its
cleanup.

