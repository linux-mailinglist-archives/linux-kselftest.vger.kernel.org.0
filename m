Return-Path: <linux-kselftest+bounces-648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A137FA119
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 14:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2117B20A96
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5612EB0C;
	Mon, 27 Nov 2023 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJeG2cWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C491;
	Mon, 27 Nov 2023 05:29:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvedOg7JyELroDurQOp1DFYAKdq/JJAboSyqFiPoaShuWf2KA/TEEdist+Bn/g3tPVBbd3J8znqxDECJzqqEXQCNu1U19bRjj6W3+cUppH+p21D8pU4x6pSQo+dDf9XEVYqzOEHy4QaZLb6MvRqpaxvGbnBHK73nznrlIHmA6CdG5DrzmfpYkbTyDKM3PZ3OWw1OK1GMp6C1ufeDGH3sv6T6fusB3ttOZpnlWvlFM7XQAcj0XT7vl4Cldlr0SoeV43XAvM1qwEh+iuY0GLVPnqj58SEgHZhIeWa6y3bDN0+eZJLkP8UNFDe9NkTEw1RpjcO9+cZTPXm3tSbm4hVfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk89eI99pWaDAwDwDPT3JxQC/MfwIytQZmRoXyJhDq8=;
 b=cdDPT2E06uNdrDSZBGAYDjY7XT5LyLcMmqIOIf2veOq7SPcZrK3exw4m1vJWkgdyEOCerxXVjOqn5B7HmLFitn1KwSbNBdLcywfNyzh6y/X+w/oU2t1P9fApbmEgp6IVV3xJ5vTEp1p049S8l14lc0fa+4E8/lOv4S/dPMvUPB3HZ85AsYBXtX8RcDoFm3PzPCCvnLUWF6Dt+bzIkd+eCvyiUG60IBszuIQbGDeSyQuWx/fnHisaezblh1DJyxSKv6Fms5/oh2XpeMVXHKTjfkGIEMuxT7wbOCBJ7SlZJrtKBZcrm8hJRAVJrcCaPanqG2FyjklLSE5nWhdH3+D9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk89eI99pWaDAwDwDPT3JxQC/MfwIytQZmRoXyJhDq8=;
 b=LJeG2cWsvpOQdV3owhIKBrTgkTjDxSzoAI32qNhcbV2PqNcdJdBJ/Ds9/BH+6erS4TklV0lGIrwhG/aZcUHiEf+5HX9JyfTJ9Q5l+3bGD6sojtlJCLTMM1eU/iYhXq6dF5op1JRllUUx9kuYMpNp8aNqvN0qOrHvW17z5fgD5eElBY+f6cPPu4EfC+oUzeBzQqFYc5ELiLzgIlXxIcyMhn3Eo1vMCa9FHyXZDpUDBJy6BvYer6fyJJxlWSAjkdh7pz+bRBmWR24AlkWcCBllzHTp/i+yBxIQZRftKrP2UpIRPTofiidtUj0XsUavaryTOV+/XXoHML12X6zBlFrzrg==
Received: from CY5PR14CA0014.namprd14.prod.outlook.com (2603:10b6:930:2::27)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 13:29:21 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::29) by CY5PR14CA0014.outlook.office365.com
 (2603:10b6:930:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Mon, 27 Nov 2023 13:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 13:29:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 05:29:08 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 05:29:04 -0800
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
 <87cyvzfagj.fsf@nvidia.com> <ZWGRCK4D64EfUybp@Laptop-X1>
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
Date: Mon, 27 Nov 2023 14:19:08 +0100
In-Reply-To: <ZWGRCK4D64EfUybp@Laptop-X1>
Message-ID: <87bkbfe34x.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 30edee7a-17a9-4e24-3f1f-08dbef4cdd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NnU5yPksfwQ5EjwRHbEIeNfHL9kWX5/96zd5UlX1Pe80nwLhSj+QIu52IAGckheMywPjcWMxvQptzG7n2O03b+OVAvP++Rcpn0+FzfMJxca0+85RKILeQ4Xbuq4k/rId5sL1uIw9DVRmkLh4tMDp8e/S1DQnZN0VOe67OAW7pMpBEjHS13ZO7HeUT7YwtkZM4afHXsklgEg1triv6ahRN7fTKak1Pi5xP4O1s1gwkv7K4EgRbO2f7QUHTaIDpoFyHv+vut0RtVW0lMhIbOO+ekLlKdtK900heynpW2Un8mY18KCPLxUbHUS4EBMJtB4Q3+L2rc2tPlOptTNi8GcXX/cC30YbNiKSVn7I4ERzoEhkzDHMaAOVpJ5dEDVkthtm90smOhF0shQITHqy3uCLJMSbC3EpnmQUuVoThU4e/OYDRetIVQ7QyBTdR5EuT1G32vpOcT2VK+jg7mQpWAzscho9a1iVSgejKVnzR9Dc4K8WOyWnBCwWcCPyjpKXoaYg8N6nIOxc5V9jt/gm6LR/STfS960JoMTWyjAzoleJN7OfR1jyNxO8KPnndop37h7eFqvXaWOdHQ7qH+X/D+nHSCqDdAnTME8tGijBIqT8VEzit2QSexpI8gv0xOG+eDxa6piPqT52IuWYor9mLUsGvv9R1FgCuvh7j8XJWkfVbr2zlf5NjNvuCmMcNImW+zbTlp8H+OPbjUipcZzGPpTFkr3dMTW4b+jIAohXalrRq9/7VwceNs9S8FAwTeSiA0juIKr1m9z7nC9g9psjmXXRrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(82740400003)(356005)(7636003)(40460700003)(86362001)(316002)(6916009)(54906003)(8936002)(8676002)(41300700001)(70586007)(70206006)(966005)(478600001)(4326008)(5660300002)(7416002)(2906002)(47076005)(40480700001)(426003)(336012)(16526019)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:29:20.5984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30edee7a-17a9-4e24-3f1f-08dbef4cdd00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420


Hangbin Liu <liuhangbin@gmail.com> writes:

> On Fri, Nov 24, 2023 at 03:35:51PM +0100, Petr Machata wrote:
>> 
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>> 
>> > +		fi
>> > +	done
>> > +
>> > +	[ $errexit -eq 1 ] && set -e
>> > +	return 0
>> > +}
>> > +
>> > +# By default, remove all netns before EXIT.
>> > +cleanup_all_ns()
>> > +{
>> > +	cleanup_ns $NS_LIST
>> > +}
>> > +trap cleanup_all_ns EXIT
>> 
>> Hmm, OK, this is a showstopper for inclusion from forwarding/lib.sh,
>> because basically all users of forwarding/lib.sh use the EXIT trap.
>> 
>> I wonder if we need something like these push_cleanup / on_exit helpers:
>> 
>> 	https://github.com/pmachata/stuff/blob/master/ptp-test/lib.sh#L15
>
> When I added this, I just want to make sure the netns are cleaned up if the
> client script forgot. I think the client script trap function should
> cover this one, no?

So the motivation makes sense. But in general, invoking cleanup from the
same abstraction layer that acquired the resource, makes the code easier
to analyze. And in particular here that we are talking about traps,
which are a global resource, and one that the client might well want to
use for their own management. The client should be using the trap
instead of the framework.

The framework might expose APIs to allow clients to register cleanups
etc., which the framework itself is then free to use of course, for
resources that it itself has acquired. But even with these APIs in place
I think it would be better if the client that acquires a resource also
schedules its release. (Though it's not as clear-cut in that case.)

>> 
>> But I don't want to force this on your already large patchset :)
>
> Yes, Paolo also told me that this is too large. I will break it to
> 2 path set or merge some small patches together for next version.
>
>> So just ignore the bit about including from forwarding/lib.sh.
>
>> Actually I take this back. The cleanup should be invoked from where the
>> init was called. I don't think the library should be auto-invoking it,
>> the client scripts should. Whether through a trap or otherwise.
>
> OK, also makes sense. I will remove this trap.
>
> Thanks for all your comments.
> Hangbin


