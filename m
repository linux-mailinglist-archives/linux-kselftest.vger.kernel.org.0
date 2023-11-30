Return-Path: <linux-kselftest+bounces-886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF947FED14
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 11:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FA5B20E09
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968222320;
	Thu, 30 Nov 2023 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cg+ixuM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDE10D0;
	Thu, 30 Nov 2023 02:42:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCuy/60W1uyTvcChDnEPZzRMJebsX9yGnzQdk2/HtgOxV5ZfrvUDfCRm5DQccjPQRSreXea22fskQ5rFpzu63cfK6BDE5xrwVIAVWvfjkWMaHoGt8sYOTYERj/zqBpMnC2JWpBwwsV6ND3jWC6O1mXumZ+ItEaXuFR+TvgYmss/ZaV6ixB9gJ267A21xboDVPqm3cK/hJzsE2eG3o3k2zJFYhO6HVpsfoQPQuWyR9Iv/Sa2fGqstHUtdOyx2Bg1phJd4xgbvpsAAOiW6w9kKhmsD8wPG6Wh1WPtTZEsc1/asbxvJ32+NmkSz0HTz6OlyisEXYVN/JhOCCX4a6iGTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPEKn7O6yhLEbFs86HTlz1nuxLI4BXNKAwSRkazJHnc=;
 b=kMBAIKFPEIck3jmWxiz+AouaEUTsPEjJWPVW4ysvivVf7guE3c6WkIwIlDQrNOtsgZ52sbE20gcuIIcX/VqIasZhj2r1j2yd7xbZA1hOMtDvtw3g0g3YUO2LJmw304r7pGPz+mWIFMXh+3O62zvBRDPwU/lkGTV9/dUZipPSP8uL8hV+Ja2JoNkR3LmcLva4JynMueCq+BjqJJYLx/m07CMMsamJuCfk6wDj3Bfby7apX1qWYddyprvFvLzbp8IHrQ+ClFOPfRQEAPN83NAL47jmJ3zhuzI2KyCFZGPOvIulEGoGwQLkFjXjySqQgMlG+g3eO9senUzsVYJmOay0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPEKn7O6yhLEbFs86HTlz1nuxLI4BXNKAwSRkazJHnc=;
 b=Cg+ixuM5iHBgBnQrojVCdB+NF8CrowHrSWBGXqRcjTCzBuKxXuA8gpFNJFiAE9DfyqG6FuZzzjv9obC8Lunnkydmdyv3JWBF61cByqWq1djrhc8CkeV4iDOi06XElfIzn3wq/ijT+Np0W+abmgcuo6jPOirUafEdnePpCNoCLaz9/eZTHeY2PKPvVrsxeCIwosSX3v7gdJd7RQfk1sl+OUZNIX5Ci38ENlDPmpfsIAPXXEU9sy+AFd7lUKvARSpNZru3HsTml7xo+qIQZ//fI7yYjNdtwhBx4CZcz0wSYTJOaxU2JLmwtw+P2WpiGb2ugVXQjprg3v1i8kmYP9DCDA==
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 10:42:19 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Thu, 30 Nov 2023 10:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 10:42:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 02:42:09 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 02:42:05 -0800
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-2-liuhangbin@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>, Po-Hsu Lin
	<po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>, "Petr
 Machata" <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>, "Jaehee
 Park" <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "Francesco
 Ruggeri" <fruggeri@arista.com>, Justin Iurman <justin.iurman@uliege.be>, "Xin
 Long" <lucien.xin@gmail.com>
Subject: Re: [PATCHv2 net-next 01/14] selftests/net: add lib.sh
Date: Thu, 30 Nov 2023 11:40:05 +0100
In-Reply-To: <20231130040105.1265779-2-liuhangbin@gmail.com>
Message-ID: <877clza5fo.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0baed5-c273-4032-ff49-08dbf19106b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0t2gCOPz9FY8Ja9cqJyYPhJpWPOK3/z4luGRw0dYk/wFPhke9KFJYvcamqGSsF9VdZjFWuPPZ+LJSFEfdbhaNiztUcYVIcBiesSx1TQpZs+ScOmCdqh9mddpGPEBXewtQNdhtpGbUzgtcnmivVjqhmPvTdinOMcKVi9z23EYfTJsA2mdPicH8erCL+Gdl07LQeu4XkLncmnRweX3XNq+Py+fnRwcT1s8uxRDB1oUNHjDRXaHLLED/FAJ/3ucsjBNl+HDLdS06vmv0u2hklsqvWHgf5Tc02TQFxEGqlXfQKnJ4cDSjLzmzmNstJzxYgW9BCuVZfQtmH7ixA4VD4yiKp+Udxngfae0c0T9w6wBATg/5odIsIaz/znnxnY01FgXqL/izK+nKLOSYu5LV0tQQIWcyXIeTMyNU45Wyv5QGzkpA0HF0hln9V0ajFnamqb9wNh3FWlp0/e3HJTD04k3p69rqHJHwY9w8BV68UiTQgjnhTe8NAqs0ZTAPCerysfDrd5wbs+7oPeJQIzmexjdfI5gxPlXfJZYeR22trJHMzlWP5f6DDR15Ctf92uRLjPBqBZaVnGQ4/KWgoD/WGcLi6JAbu2kTcHeL5zGmiKxXRLqx32zOP8ld7/ZOdvQYh7hopbjql2AOozE5CLVq30/KyHeYm4HI5uu+jO8NoepXTEQ85drdM/hfG6kb6aLy5m899HPGMtwzH2d2N0NpNgST9i/Ee2F6NNk1LP0DdP3ZfvRI3JMaLXKRi1HUsEz2btkrb4/yQPaAdMQtDxXME7jkxTUWOocxQL8hoa/sLKGFgA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(336012)(426003)(26005)(16526019)(47076005)(36860700001)(478600001)(7416002)(5660300002)(2906002)(4744005)(41300700001)(70586007)(4326008)(8676002)(8936002)(6916009)(54906003)(70206006)(316002)(202311291699003)(356005)(7636003)(82740400003)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:42:18.6702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0baed5-c273-4032-ff49-08dbf19106b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915


Hangbin Liu <liuhangbin@gmail.com> writes:

> Add a lib.sh for net selftests. This file can be used to define commonly
> used variables and functions. Some commonly used functions can be moved
> from forwarding/lib.sh to this lib file. e.g. busywait().
>
> Add function setup_ns() for user to create unique namespaces with given
> prefix name.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

LGTM. I took it for a spin with a couple tests that we use for mlxsw,
mainly to make sure the "source ../lib.sh" bit works when invoking tests
from other directories. All seems fine.

Reviewed-by: Petr Machata <petrm@nvidia.com>

