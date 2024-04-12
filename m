Return-Path: <linux-kselftest+bounces-7777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0B8A28C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2C41C2229C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438150286;
	Fri, 12 Apr 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwc7pFR8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601B50277;
	Fri, 12 Apr 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908997; cv=fail; b=cMeuRp6dJKox11Kb1OxV3rZ+IcB2bglPmHOz1w7LK4sTrg/QW++zVBVttvcfpy2/E/anXJEFS4WHxpY33V+Azm1sk+9S9p72DfKTFmmeAjf96pwAA/UJH9OiAQMOWtVwdBd/TPiLMmm9oHuUpEgpGKq9MuqK8N/4FKDicxcuqDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908997; c=relaxed/simple;
	bh=mBuBVDfA8I56CMocji1Yhy/UuYuawbiNh6lTuhqy7pE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=opXAUykfXjYTkKWppsrU6nisF+R9jLKP/AMAAW4IxLLZv1TVyLDJZua34xjtijeRLhwWH3SPkhHoTrIO0iFjlMEN+0tp3T8EBRnyF1yVpNRLfWEGNmE5RVOS6ImFLT0U4dqfEj2dxXy5ATO14p4GHmpvoUMaSKeW9Tg3VA4ISU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwc7pFR8; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA0xoM/1vazLM3gRztF/3jO97i/Tq/CAq0uaWPNFMR60XVS7DbDTZZ+wOA4TBKLqbhnDJ4oOEMigV8BIJz0Rnn0URLTmk1diO6ovAD8GinsoqiB4KWnxRUuHSVK8pk+L11MZU2FN3a4wjPGCMZnCEB6P4Yl4FZAoTmSQH8nZooLYIIEYF06HNBGsufy2XbJ0Da0fOU424zt8vRLvpyW0Za06U7qvdN3y30vLCWrAdgqLPL3b1Y0Sy35ivh5LnY1XiCo+XDKMNhLA6XuO/tYOsePxe9/YLXk26ZtYb6uuPAZ/7Mj8sajX1kL6KJUagTmncdqUPMZwLS/E4Ub8tdlnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx9+moljp9OARB+DVgUsaDbLjbdmTAN8/fWE4kcMrN4=;
 b=bG0sceotVc5f00myHSUAMGk90ObIvPitkD3c5AcGyDfZ7BsttJE/VZgX2Kpscgpu5hrziS2lobD4nyu4UFKZhwezpVNyxvK/SCy0589VG2LVEIcbQX54GprAZD/sja+0/TU+LSjbel3J+nMWPaMpr9nvtHNR29a91XaB43QHX5FUWXq30+sLqT0C9sO5JoL0umzF6e7GVQLCBtEUd1dR7qPKJEruENKpQemPY8Ft9C1BsEcM6CuqXgO0KFRCco0Ah1Y4K1cqAP5JboZpG6Q3nlGKnsjhNcd048S66bZFn5UMRtk05RHous45Yu43sn06b5sdu82QtxYqRUEmoMTnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx9+moljp9OARB+DVgUsaDbLjbdmTAN8/fWE4kcMrN4=;
 b=qwc7pFR8C6kxqVSnT5DIVU/gMv7tDnQeSenYCg3tc4fkPIIUmlGfQstzKGEZWXL+DdUxMLwBYCoVuapGXOLy2SM11iRoN3/dgfKf6WIPUkqcOkYFNMh2QxVmGvinSv3K4+5CH9W9VFpQdsXfOau8IXfE3Bb+rShZ+wE37vz3lXB1y6vlJiJ7aId9U9/7kCbcef55x5E5snasyDU/BI8Os8D7Akgvn/+5zzM4nm79XAcediAv/42WA4ZF2fRxlxlQMS1imau1hwxDfWCoPli6ms7IC/VeNYDEjfqaAYcWy2RNOyKhhBN6TLonMFl78mzi2SsZAmqxGuo3P6acIFeWUQ==
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 08:03:07 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::94) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Fri, 12 Apr 2024 08:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:03:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:02:52 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:02:48 -0700
References: <20240411012815.174400-1-kuba@kernel.org>
 <20240411012815.174400-4-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] selftests: net: print report check
 location in python tests
Date: Fri, 12 Apr 2024 09:45:40 +0200
In-Reply-To: <20240411012815.174400-4-kuba@kernel.org>
Message-ID: <87h6g7f1p7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 568f77df-1ef4-47a1-cd20-08dc5ac6fcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BmnUUWhIe8AbGfZvxNowlBMvTLPCqYlNrsQmIjTtz0NhurkumAJoDBT1DqFTJl/cNTwt/Ul+ILHvfVt1UJDmQ1WwL1BhiMMnk5YSxGt8AGF0B7wa0duHs88mRZf9EaLMR46UYV0zprP+XhJU9XOrKnbQ13ZaTSnIH5aj+XHY4PbvgpwyJvmt2DQEmBW4uaWFs0rN7h4xTO/Q27rgc08UldRoh/sCc8MPlVmyf95oV5QWcWaTpGwg/M8LipguxrUih+yD5Goa9daxIpfT3w2AVeZ97xPigePwBt3Ngv8PC/P0rCoQCvNX253wA7jzZ9sr9ysurHvTTj0+OGQ1ojbKrAzJYhOMw9CnHkKSbCHy6E2kFgg0vmKg3Aqr+eSumBNVoV14DVhDIrcn+TVMTN4dl4nn99s2zS/nsOKTZGgRdPd1u9BnpdtjwB2+FXK3TUlA/NW7QAb+dLnrrVzf1/PhT46zY+aaB3YYTt1GZneMp9/tx8Jvvla4Lk47v3uuUW/IgRIc9505RgXCilPIZ038pEPtJ2z9Edxtnozkpw82FG0Lh/qhr3s9rJAZzQYk/Brl3rLF7zdYo0vqfuGDkSdsOPs/N9W5WSrkPK8k+Gw+6ETC9OzAXOPC6Fof4Z9U14fKEGWcy8j2kbKkaolSshyffdfc2xIFHb3o6pyFtaSHZ4rMU8STQ+TWn8tCeUTyk1/o/nb709betNn+15aUdssNfcEcIuygLllQx8VMNQux7WTMlz7W7sRNovCpQ9V9MdjY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:03:06.8103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568f77df-1ef4-47a1-cd20-08dc5ac6fcad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485


Jakub Kicinski <kuba@kernel.org> writes:

> Developing Python tests is a bit annoying because when test fails
> we only print the fail message and no info about which exact check
> led to it. Print the location (the first line of this example is new):
>
>   # At /root/ksft-net-drv/./net/nl_netdev.py line 38:
>   # Check failed 0 != 10
>   not ok 3 nl_netdev.page_pool_check
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> +def _fail(*args):
> +    global KSFT_RESULT
> +    KSFT_RESULT = False
> +
> +    frame = inspect.stack()[2]
> +    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
> +    ksft_pr(" ".join([str(a) for a in args]))

I think this could have just been ksft_pr(*args) like before, but
whatever.

> +
>  def ksft_eq(a, b, comment=""):
>      global KSFT_RESULT
>      if a != b:
> -        KSFT_RESULT = False
> -        ksft_pr("Check failed", a, "!=", b, comment)
> +        _fail("Check failed", a, "!=", b, comment)

