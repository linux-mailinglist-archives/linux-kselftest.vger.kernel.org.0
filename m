Return-Path: <linux-kselftest+bounces-647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CE7FA06B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 14:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC551C20A0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE82D02B;
	Mon, 27 Nov 2023 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ss4Sy8rF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33842AA;
	Mon, 27 Nov 2023 05:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a05o/0T+2WlYMLDSgs0p+zyVO8ue6+RVLxWPofYACCjobFo5j8+bwZ13iQPb6oIlxOtx96ojSJAh5LJFAEOSEOlDdFTf1k6Do7ZwaqUGNJPvj6z+tmdUU1twCnSwyJ+TuR2YKXM6uqshk5stQO3Y6hjSTJZk+Tdl1r8XFbhJllMUFuB4ZAWsUpzKKo3tad85myW2wcPVPUM1gMZc7zqslTIqwg5sOqh7l08snLLd7QY7dZrVvyDKMzs1VIMqf7ojVROrIelWJ87FB/unbbTz5JOz30r2q85BP5PveOH6MGVibzyHDr/96OtrezsJtZxD4Pe8OQ+Qo+YpPyRhp4YGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgjVwhVnb/i9xLhcaLV0iKWoTC5goHrUnFLwuVWuuZs=;
 b=TLGCrCOMAAtMHqY+cBnyyOMbtt6UP6GvHHjwnEDPl3S4ZsjPGnwtO61E9etCp8hakPafuu15ZJZr94FYKFXkEU87wq7vuHqgOk9kUuGoET7t9FmIUYP1LVBhO77Xc9Gc+dPvHXPuMhGXoWnRjxJwhcQYfZZqc9KRb6+ADMW2hfzKmiRZpd1G3IIK5HyPrQaEwEmJywsz3AVmEqZP0K7JQS4saB0+o4/pdBxqgk4A57eNxOr1AIIdvetPGMytUDCWHSaOh93zwPnkSd1zsIhC1yXBCpsf5kYI5sUwXfPYvCdyYBUTl8iHsN8jeMd2KVDJ0j3KSKSCeJLjDOvOrM+qWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgjVwhVnb/i9xLhcaLV0iKWoTC5goHrUnFLwuVWuuZs=;
 b=ss4Sy8rFURAhyMrmIO4hOS780bU+Xuql+54Ija9l7FO825y9mEsauE5GhdQswxX/W/SsbVanUDP1wp7uFMEhIFwjC0glaVLEicC4PVIK+XZAheCXhed6Q76fj5s3rAk2+DLKv9yXjfGG1pjAP83LShbPHLVIaRbpr4DzATZS/ekLYUU35d9uKS7GL3fAgbPrp6jXIoS+NyZGq1gtOf0a2w10Ct7yL51pxv41nxfmfDvKGA19dtt3vG8SOgywx5TW+wYYr2xLbXEr8uzUjZxzaRbHw2O4GuVEBQxszoDOWiGgcUS5SDzgliu22KVt5x0suH6OkL1b8OiP7JLA0R9MTA==
Received: from CYZPR14CA0013.namprd14.prod.outlook.com (2603:10b6:930:8f::17)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 13:16:39 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::16) by CYZPR14CA0013.outlook.office365.com
 (2603:10b6:930:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Mon, 27 Nov 2023 13:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 13:16:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 05:16:21 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 05:16:17 -0800
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
 <87h6lbfdnh.fsf@nvidia.com> <ZWGJGDV3TKYUsqqW@Laptop-X1>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@rivosinc.com>, Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Date: Mon, 27 Nov 2023 14:15:47 +0100
In-Reply-To: <ZWGJGDV3TKYUsqqW@Laptop-X1>
Message-ID: <87fs0re3q8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e5bddc-d776-4fe3-502d-08dbef4b1752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oc2aEeVidIpQcVVRtQI61i4cSNqmoRsXpL2zISu+Lqa6akcpSNvd4m17noJnoDf1PWD8TCkY10Y6EeYW+hO28YUv+g0YJdDNbJPMrx6l+fBLtFS4/9KBco/WpuuWZgVqBxYUknInhQefsZKtJsXg+QUHB3dBKCIW7C/gnkIS4TNMydwlXqTMiq7qaPfQjSZK6QZHlnVSsSXUxNVKq2GM74d0vAJQlMpKX/OWjDkUFg8GT7U2xWekD/4NXae8CeMqUhusdbXWuP0tCn0ixgAXCg/XM//n4S1IH695WVcPPWfiXetZ1ESY5l7q6EAX+Nk/iIzQRtNUTGbIncmw/gjvyz6eG1/kQZnAKbM7zT2tYV/N/ShBTf+p4zzMMq49TjdlkxNvgYTECrHlV+nxe1oBLOamcUZYza4KWjQH/kALKocWM8tykNwShpqvRMuwOZsAtv9cd5Xzceeh/OEYLn5qhkdVLqEEBAnAKn/MidYEldwz++8Xa7FRLB70tbQlMa8yx6NyydF9ADRVoZnVJlmDMCUr//yiyokigRyOpyZFQWwwGsusw5LTp4QzrjCbRNQgzha33sXrQO8zndHkDNliari1eFfFEvmHUpUWYeG+MzXdWCnUJTkBRcSRvrYBaA93GF+nN0cYVifd4pJYnlZbThFk5orPbWqQAUp+YxrShPMilHke6TB3aVIcGdX4etdXk+17cPFm+wZTUO5uFZR6u1p+e7jBNoj4kiECcv2F+E9jBHp7fNrUxILVgOWbSRZT
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(41300700001)(86362001)(6666004)(40460700003)(5660300002)(2906002)(7416002)(356005)(4326008)(8676002)(8936002)(36756003)(70206006)(54906003)(70586007)(6916009)(2616005)(478600001)(316002)(26005)(16526019)(7636003)(336012)(82740400003)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:16:39.4819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5bddc-d776-4fe3-502d-08dbef4b1752
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650


Hangbin Liu <liuhangbin@gmail.com> writes:

> On Fri, Nov 24, 2023 at 03:05:18PM +0100, Petr Machata wrote:
>> 
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>> 
>> > +# Helpers
>> > +busywait()
>> > +{
>> > +	local timeout=$1; shift
>> > +
>> > +	local start_time="$(date -u +%s%3N)"
>> > +	while true
>> > +	do
>> > +		local out
>> > +		out=$($@)
>> > +		local ret=$?
>> > +		if ((!ret)); then
>> > +			echo -n "$out"
>> > +			return 0
>> > +		fi
>> > +
>> > +		local current_time="$(date -u +%s%3N)"
>> > +		if ((current_time - start_time > timeout)); then
>> > +			echo -n "$out"
>> > +			return 1
>> > +		fi
>> > +	done
>> > +}
>> 
>> This is lifted from forwarding/lib.sh, right? Would it make sense to
>
> Yes.
>
>> just source this new file from forwarding/lib.sh instead of copying
>
> Do you mean let net/forwarding/lib.sh source net.lib, and let other net
> tests source the net/forwarding/lib.sh?
>
> Or move the busywait() function from net/forwarding/lib.sh to net.lib.
> Then let net/forwarding/lib.sh source net.lib?

This.

>> stuff around? I imagine there will eventually be more commonality, and
>> when that pops up, we can just shuffle the forwarding code to
>> net/lib.sh.
>
> Yes, make sense.
>
> Thanks
> Hangbin


