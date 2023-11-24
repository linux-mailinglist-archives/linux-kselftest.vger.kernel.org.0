Return-Path: <linux-kselftest+bounces-552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75B7F77C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AB1B20F2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1B2E635;
	Fri, 24 Nov 2023 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7lhjyWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA0172A;
	Fri, 24 Nov 2023 07:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKaSd8e2N0GZCcN0zGr5JkZTB6j0DuafMfnM2VlttAm6w+gd7tDR6lCCoGwk2gWBoOEVaClwdePv7CpSd2vFKtgyfEvm41n6u+yLLVW335dwdA4nMxoLpGTiKm32hUmhs8fh6BHyTcmWzdnhXxrjMCjoL6dEilkT1xeACGCMMIxGwd4JzRc9l3dzlOl2fx7HOKnI+v8+djMHsd//wxyw/1rhXYPGF4arGVHf6TiMcxePV5NjFaILX6RQfk7P2Smg9IgxLvCBHjbPr7tPns36mOqFMGm5r5Dz+4+7zwBal6NoD/u2dNWRfj2WhOSStID4Yrf0YCiokrw59hfKEbqY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MjmsKUvLWjDeJ6NLdD9rS34+oQrztxpGQCVdTKUxxU=;
 b=dNukqnHJ/6Oh6Z4IsdOWkmI3cWL1Io3o/umY9uGnSDXRd+2Jkf3AB8Qqb8aB55RXqczIGRaqwePt1UYtrkCsikrMJekEVCaM5/Q3/tct8NewfL861e5OUQtF4Xxv6KQSX6pea008M5Uv9d6bzLTbZnU0EvAZVR46JtvU4FZZzeCiroMlRW9Pg1Drt5imjk8siHix38AI5dxx2gRFOTe9SZDNulsyvjsZsqosTSXvGB0a7JFOT9f5w7Zp44fUBJX6WBY6LYa0uEi/4lgmMAnWLHFwirgOnPSm4ew1X8VGhdLJSb55twZ3FiwX10k7JPxn6/UWtZlHkiZ6dPuiKOd8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MjmsKUvLWjDeJ6NLdD9rS34+oQrztxpGQCVdTKUxxU=;
 b=F7lhjyWE8IhisMDmeeIedTbF4ytqH38SLwF2qf5NygA5mNCtm/l3rNjPykKt0q2DR95eY1K/qKW2XbJUfYyhXGOmjstvBDv+Y8PM0QSrHqkhOGb6McNrlNSZ3zHpbSMv69zxqDxBCvQyF1Hl/7+2hQqRfQ2LE6bfyQ3v+dQSogPga5SMVt+2TG4nyWy/GtMwDEiqx1nrweCrt9dqW8Z+4TIJ8Hx3btL+j9vle09RTJUNSpl/KDvh5ZEUcwaSAHpraB7iSg1clCtjpceNILxafsOC8HDBdk14lrpqmBR/sHLYf9vVCSM2D2f68JrOPHI/Hhyxlnl2B3/3CW2W4uHtEA==
Received: from MN2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:208:1b4::21)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 15:28:25 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::8d) by MN2PR15CA0008.outlook.office365.com
 (2603:10b6:208:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Fri, 24 Nov 2023 15:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 15:28:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 07:28:12 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 07:28:08 -0800
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
 <87cyvzfagj.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Shuah Khan"
	<shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@rivosinc.com>, Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Date: Fri, 24 Nov 2023 16:25:33 +0100
In-Reply-To: <87cyvzfagj.fsf@nvidia.com>
Message-ID: <878r6nf9x5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdf9329-a640-467d-d9f0-08dbed020010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w0OosCAfBhPPxjIw9onW4m+QX5v8dG4ga7MmSKEZlXS+fRvbxh8ZHZJneHyPeQeMEwzFPIWN1njFFnO/h+FAcKJ1baWYZFUfsOIUmwTAXFVZHLdI3twR4D2V0PgYSnVzssCRKJ9ZkAaSx4fIeT3hsKRRAJWRKiv3TRS9KqsnF/UbieauxZ032TUsD1gdpRoc1o7NUTk2ETEu3VdU7hYn7WLldAnY8rzS5Yhn+WkDiIH870Mg3aHemmCFi7fMSIge2mdZ1Ay3QB+w3AJnp0+QudMJehkhp7c6qVG71rt34xT25IYIZMqF2awQfCKXbUmNn9mj3nYHtzJEdVwIDFV6mCGjCqZLKlJHFFbSNdZJDI3aM/gfmQNFZhC4GMJ21p0UulxghIiqKNfbX+rBD/RIK6nrisydk5usRe7C1UYtT12f0/EqDsH/uddiaQF/AOwOS71H8r3CrtgmVegxnAr1swX+GF3VscXibqIkVENSqVKVo+MOEHb7tYDSDt30BafFALxq6VRQmdL55lHdoIRB412jCzbAFM4lsPSsa0IajQlzLnEziDkpAAcOTM8bR9opAtHEhAXq0NX3KwGYHYghB3KydpZSKWxyBcP/7pMZ6sny2aE4jz+qi68ucGjuq4O/7CxCP7rcsE0L4BceQoDZe9soylvVlrKRYOTnTinoqtVWxISmGySBESC/fWSGyP9D13DZir3akYecJ3pRn1qMRBTu06qZgqYsE7KphvqZMh1wns78NG8mbydufGepjav2
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(2616005)(7636003)(356005)(47076005)(16526019)(426003)(336012)(26005)(36860700001)(40480700001)(82740400003)(40460700003)(478600001)(6200100001)(6666004)(316002)(70206006)(70586007)(54906003)(37006003)(2906002)(8936002)(8676002)(4326008)(6862004)(4744005)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 15:28:24.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdf9329-a640-467d-d9f0-08dbed020010
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698


Petr Machata <petrm@nvidia.com> writes:

> Hangbin Liu <liuhangbin@gmail.com> writes:
>
>> +# By default, remove all netns before EXIT.
>> +cleanup_all_ns()
>> +{
>> +	cleanup_ns $NS_LIST
>> +}
>> +trap cleanup_all_ns EXIT
>
> Hmm, OK, this is a showstopper for inclusion from forwarding/lib.sh,
> because basically all users of forwarding/lib.sh use the EXIT trap.
[...]
> So just ignore the bit about including from forwarding/lib.sh.

Actually I take this back. The cleanup should be invoked from where the
init was called. I don't think the library should be auto-invoking it,
the client scripts should. Whether through a trap or otherwise.

