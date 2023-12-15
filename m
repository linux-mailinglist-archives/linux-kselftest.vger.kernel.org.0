Return-Path: <linux-kselftest+bounces-2086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE81814EC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C87F1F2102D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84730136;
	Fri, 15 Dec 2023 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CaUYSY23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E545BE5;
	Fri, 15 Dec 2023 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRM1/eJh+BBuzSJg601ecHPw301M6BxCxCGiFSMIQXR7kZQBmWU+n/hw3ZM7Ll7toaod03iTCLtTvubzzPvg9EtfBJ5e5OylA5o9/L7fCrbD8CrBbJpyTis8iByLiluM9SE1saZR0iNtY3gyn1ZpsCycezv9BFSggKIfbrAvd/t8fVxcVPJabQWDOpkt1RkUz3noYPkf7C0DfUcatZYQraaJFrsHcu9HhIHcoDtek53Pf9fVjOylkZAzry+UByGLJyXjm7oeHemrgfImJBvk+2URkiqDFQU629OprVf5F2U2fIHDSK7G9vFVYjk87C1PeFUz/anjiys08QMdIngIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTMSUHrvvZnC4HzReFSsrb1af0b0d7nqtL4ZXLRgA/4=;
 b=jMvHoRm/HsknKTjeyeQ/JNoXw85pwqb9vGO3HdPQS7mNRLBsQ7+cOZncrotf1gS/9cuencanIiUt3YFRZeJ+b2MUSZbcwaZZecXRJk9cWsYqhHO0EBKEuCXZMFSAMxVRkSdh+zCYv9JUn4rIyWgrwZKbfWSIEbAFZHhQtfI7owbD/Le5r3acnwGd8vVs3KZgKtrcMtqaf2gGrdz7lp6zV+O0Hlz6Kz+gONNzdbpticRexp2P+wFD3rVdOWYIbW/Izbwg50LPAJqWj3xwU/eioSpexQYPl+dywBgStFcyb278pnUWY9YdwCDQTuJ2KOolO/Jea6uPE+on1NsMovJlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTMSUHrvvZnC4HzReFSsrb1af0b0d7nqtL4ZXLRgA/4=;
 b=CaUYSY231QX5K5j+YZ7/MQKkzLUVw/tMMNaPS/ZfC29VpOnKixlAcLB956OLulWUUZXcZzo1G4L7UX+qHJ4ZBF13veXJ+nCyhl8wrtYSw8Joo5lfd2amGiatoTGMzbvA8f2Nvzx3kv5jmtlxYD2uakP7fp3Vniu+Zwv8gGLvBGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 17:27:14 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 17:27:14 +0000
Date: Fri, 15 Dec 2023 19:27:10 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
	p-varis@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 02/10] selftests: forwarding: ethtool_mm:
 fall back to aggregate if device does not report pMAC stats
Message-ID: <20231215172710.v6gtreijeqzocmv4@skbuf>
References: <20231215132048.43727-1-rogerq@kernel.org>
 <20231215132048.43727-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215132048.43727-3-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR02CA0071.eurprd02.prod.outlook.com
 (2603:10a6:802:14::42) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9446600d-0677-4a69-aa31-08dbfd931409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YjuESx6L1gAh6YH1vFrnHlvLZsE8pUSzvbnQKeDKA95MjhW9EndwZwOjvbQnx08mMGFH5sru2dSR+J+6hQQi1j5sIo2PpHQdm8QFTPJrr5gOyG+t91zmoO8HtdNciGqRVXyDlWQ9Qtl6DOsFC7kUjj7VxubS6i+m+wYMDEIfnWMbKHvrmXrszt3TdmAlXnxwyNaxMS8/qJTVbBJYBuoYQsnznPfBzaxCN+9b5EAeOGqjMvFhjRr1Q5gOt5U+77uoxXCK8wDHG2aMB0/DxhljdidmQxWB9cDdz0u8IToAhnu5SQFyMVbNCNhL6rZdQ8bQXUf6m3cwpPmhdCFKuq48zTJCMbh64mU85a3qx/G0y+r/0JTzdrvWvQZLQvk2OdNgBCgtjQAiG53jqRJdAdgrp8Yz0J3LHIoASL2WZ7+xIhhuJ03MCRFtrV07xsYdL3yFovMoKHoyR63S90n7AyNdjwG2bYAuqcrGctixkt4ZbQH0L3dyO+EWef0exXAT7iLwwSYpACBGBlzBfWrC5sIlthuAteXtjQ/Z7FNcVkUJnZH9mBhAoj3nG5jonwPuiv0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(33716001)(1076003)(26005)(4326008)(44832011)(8936002)(8676002)(7416002)(83380400001)(5660300002)(2906002)(6666004)(478600001)(6486002)(66946007)(66476007)(9686003)(316002)(6916009)(6512007)(66556008)(6506007)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRAM7/g15rRhhz4faMAUDVwqCn3Qpdija9/QWDCDVXjA3QpdxMzbyCUKv3yY?=
 =?us-ascii?Q?w3atCHslXFQx76p9BQQ02G2e4nevXuS/Rj2vr3YWx9GFceHebweWeqWVIdr8?=
 =?us-ascii?Q?/9pqsLJHAxXLKqXT3DEkpYjvLmAaJBOGbe0NJSEi5lNDpZ4PLV8TazIDWIlA?=
 =?us-ascii?Q?7Jzxb9tGGgDdK5T1KqpwWvyR+hyQIbTvsrmsZGELaALqoWFcb3FUn9MRPM5x?=
 =?us-ascii?Q?bqRTttqTM7+TJtqCcOcgO5sotk/jzxcovN9g326KaoVl8R8hQ+nZbAVQ5S9J?=
 =?us-ascii?Q?gwbgl1o+mTzP7gFDY1Ay1RFTcq+pY9mBqC/2agchPGha5Yc/EsE9ZYmF+Oqe?=
 =?us-ascii?Q?LsRdI2KBdL1jk595Cdngp6fh9RISgWQf6LvLx16642cxurYUKo1J075nuO1c?=
 =?us-ascii?Q?8FafEZ/wbk/VW4kuuPBzTbK9W3AXKCuGM3tLTSUVq67YAV3gloVv637N4/JA?=
 =?us-ascii?Q?XuAoFjGVCaWbvE6idAuGF0oLeXOVt8L9b6mkw6nMewAhP0HBoR3phc1IaCmc?=
 =?us-ascii?Q?NuLWCc+kkpfjJ++eGN4o8Xm5VFZgE8QSs3tWx4GfrhtfJWA3no+Xv7nDOxM1?=
 =?us-ascii?Q?09y/s0docJoZmdyUQzo3dQOZ5utJB4i/26snGj/li8cVE5hMfvxsj3ebEVLo?=
 =?us-ascii?Q?pmNZ5eO3LqDW8ULWeXGp/MeIRRlfs6+LswEemB+7Y6yH64I43MiX+V0OR5FJ?=
 =?us-ascii?Q?K9ZC01RBUWI7sT0xx62LWvq6AdoJ6ZdYC2brSH5HpFef9kPKQIlud3l/XGKd?=
 =?us-ascii?Q?QuG6i9jo5mf+JhZZKDWU9AGV5mLFG+XBpG041CfECUTOGVn7DtructR+qBNr?=
 =?us-ascii?Q?7skGs7+5gGwtu7LZVfV17EP87wHJHr99vSKhgXRNafahION1VqF7Co3BA5fX?=
 =?us-ascii?Q?0hWFIi/IXUERo7+MsvIe7/MM2BgxhMobX47yskrXu5pZEupzjNgv5rGoV3l6?=
 =?us-ascii?Q?7W7u2qiIFpCbVaH8mnkfH1M6nrAy1wvJVx8qjO0iYJVUn9MD+Moj4GqolqHP?=
 =?us-ascii?Q?Y4Na8on4PazsTqCtnt5kOysGb42nZq0wutfG08zawOc9AeJ2BFOgPjfGUcA1?=
 =?us-ascii?Q?XsXXQdpqmPcD+kyT2CWm6o5g0HRomnN1R+clBittZzb3gpj8zDHJI2dXEg9w?=
 =?us-ascii?Q?GGsKpQ65JHFJ81jdpePy6QwNmD4/FZ4gP26Di9S8GzjDIrVaDIDuoImi3CFH?=
 =?us-ascii?Q?uaM6RH5LtSqExJJh3i2pqB23EyBmeq0o4hHtEcXBNIbSQFOkFOeHCMDR11OM?=
 =?us-ascii?Q?17wG/3myGVw85MDWd05eUsGznawFjiogj4bx0J7ZaLwJf21acJUUY/qgMmbT?=
 =?us-ascii?Q?BzQXwFHZa3MSHXiFZsGlftg+GDP29NRz2OR/KTsE+Pu7NY42pk2R8adX6iW/?=
 =?us-ascii?Q?1nBeB9Z5zMKVyEEW7NLuJfMZr9v/UMeQsviwWIOAWFxxCZbjECqvg5vUUoI5?=
 =?us-ascii?Q?FcPowfxtNLvsruMYmikJQuG89Yg5kHpJfLy9jMhRj/G9+jvLXigciYjhIBDN?=
 =?us-ascii?Q?m/CbR3SfWjG5TZkbC4Cgv0HIIqDaMcLaPhogq8gEv5RhRRSLzjykMruNY1db?=
 =?us-ascii?Q?4Zfk5xKKtYsE51USgxKgr/Fxpp+LnLjp0BOvGhmzBYHR8XKTGTl8ADuAmE0x?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9446600d-0677-4a69-aa31-08dbfd931409
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:27:14.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tus3nv66Pumk5G+CQbqyTlI7PtTDc3AhtYcdZqx+uE2qe2Uk6jCd8k8jMvj0pSy4lxWF2TPWFiTqYVs4t42K4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9236

On Fri, Dec 15, 2023 at 03:20:40PM +0200, Roger Quadros wrote:
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8f6ca458af9a..763c262a3453 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -146,6 +146,15 @@ check_ethtool_mm_support()
>  	fi
>  }
>  
> +check_ethtool_pmac_std_stats_support()
> +{
> +	local dev=$1; shift
> +	local grp=$1; shift
> +
> +	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
> +		| jq '.[]."$grp" | length') ]

This is broken. $grp inside single quotes will search for the plain-text
"$grp" string, not for the $grp bash variable. Use ".[].\"$grp\" | length".

$ ./ethtool_mm.sh eno0 swp0
eno0 does not report pMAC statistics, falling back to aggregate
swp0 does not report pMAC statistics, falling back to aggregate
$ ethtool -S swp0 --all-groups --src pmac
Standard stats for swp0:
eth-phy-SymbolErrorDuringCarrier: 0
eth-mac-FramesTransmittedOK: 90017
eth-mac-FramesReceivedOK: 90033
eth-mac-FrameCheckSequenceErrors: 0
eth-mac-AlignmentErrors: 0
eth-mac-OctetsTransmittedOK: 9181138
eth-mac-OctetsReceivedOK: 9182112
eth-mac-MulticastFramesXmittedOK: 17
eth-mac-BroadcastFramesXmittedOK: 90000
eth-mac-MulticastFramesReceivedOK: 33
eth-mac-BroadcastFramesReceivedOK: 90000
eth-mac-FrameTooLongErrors: 0
eth-ctrl-MACControlFramesReceived: 0
rmon-etherStatsUndersizePkts: 0
rmon-etherStatsOversizePkts: 0
rmon-etherStatsFragments: 0
rmon-etherStatsJabbers: 0
rx-rmon-etherStatsPkts64to64Octets: 33
rx-rmon-etherStatsPkts65to127Octets: 90000
rx-rmon-etherStatsPkts128to255Octets: 0
rx-rmon-etherStatsPkts256to511Octets: 0
rx-rmon-etherStatsPkts512to1023Octets: 0
rx-rmon-etherStatsPkts1024to1526Octets: 0
rx-rmon-etherStatsPkts1527to65535Octets: 0
tx-rmon-etherStatsPkts64to64Octets: 12
tx-rmon-etherStatsPkts65to127Octets: 90005
tx-rmon-etherStatsPkts128to255Octets: 0
tx-rmon-etherStatsPkts256to511Octets: 0
tx-rmon-etherStatsPkts512to1023Octets: 0
tx-rmon-etherStatsPkts1024to1526Octets: 0
tx-rmon-etherStatsPkts1527to65535Octets: 0

> +}
> +
>  check_locked_port_support()
>  {
>  	if ! bridge -d link show | grep -q " locked"; then
> -- 
> 2.34.1
>

