Return-Path: <linux-kselftest+bounces-10002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C608C22A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 12:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDFE280DD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B7168AEF;
	Fri, 10 May 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/E8rhr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32416C693;
	Fri, 10 May 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338733; cv=fail; b=pxldF3hksOmDEdEjwVoE92BMSgtIqB8I0zaL7AuNBmZYBbMUcqi6LqqZukA1gdo95NwDgkO3vE4AkgSz1HrpVN97yWoGDf3b57R7yKmPdRuV/AaEl7rF+snCj48Qae7Ch1pw3//ZUeS6hkYP+fgcaqIVa1ohbJIrAahPNzVAuZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338733; c=relaxed/simple;
	bh=W+AkSj/GiqxTuRqJAPjy0N34cvQBFJ/U4Stq6EdN22Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qG8HlprKNCJ1fu5M3mv4cGWM0je/CrrojeLAVAlGp9gdLoOuvApxfMEFhcvDNVBaM/feiJHT54IDb4TxfYvCvvnmphZteW3kzdlVPvYobR9NT5Qw0S434tsz1HtFQq9rGdPGC964VgwavCBNBKN6rgUunQ9eSFdfD6h2tzt2Bqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/E8rhr+; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwYoOSFvOZq5vm0VBfvd8ck4VZbBOFfFfNGTWmDpBLa0Jej45dvwVnqg1Ys0Z+bhiwoK5uEFBxUQsKu7AFOxcAuElpmKecILzQ+F6sw1Z6L3QI51ddtJUyE/mKrHIaci6O6exex0GlSbxH41+BIKL2mPqOkgxQPQzbtXwyXQZOWIu8AxEPSc1VPDg6Lj6LYEbTXjawJDajB3esBHLg/tqWJV752Zi5pLpEkolKtNZ6e+6jmmzr7t4+cyjQ7/8mxC9RWTypZfse7mduvHkS/qJmfveE2KzMf+NZzuo59EfPGmFRMklXWRnwnqnzYVNu+n2XAe6T85OFkA/aPkv/ByxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFUUJm5xExOt4ej8Kpnr2Yl23gH7sRkXJJzhu5KoImw=;
 b=SOlOxaUgDBasHlAiFMEopa/6H1L9gq/5hf4610I22R68URy8cThEdT7MXxZk92cEK3dQGv1VcUztp+JEOfqvLGUiGZNW/xSnK56vxa1vPBqCh1nDPmR7sAzOxZsEytV43bFnU6haOar1Re9jvjc/2AvcKqTRWEjoKa9CwBK1jRJpzRoPrqmqL74PS4dEAupyH8jMDv9hMeA901/P81meVxW38wR3Br5WyUo+Ofbf0q2CCDejpFcPPEylepd0/h6pu11eH91iYVaJl4jelu7rfGHATNrhkOLvaFmdhp18RxAxgF0E/LX0rcnpIUwyQ+Q4n9K/PZDDe5CJcI9Bz9yTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFUUJm5xExOt4ej8Kpnr2Yl23gH7sRkXJJzhu5KoImw=;
 b=k/E8rhr+a6AMWLz1XyD7n06Im7z2cfVFsMjQVXnHy4UrxMsB/JIZu/EsSzZ0TG+BTpZxXNu0Q2c0RvMMV4Lh0sIiBRc5zFdbftIJWMJq1MDMdJqghbMRb3uZKhTkPOHbakW8A9GREuUOh1O7t4evG68MaEngph7sYvaxOUN/6sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19)
 by AM7PR04MB6856.eurprd04.prod.outlook.com (2603:10a6:20b:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 10:58:47 +0000
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884]) by DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 10:58:47 +0000
Date: Fri, 10 May 2024 13:58:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
	liuhangbin@gmail.com, bpoirier@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate the
 expected failures
Message-ID: <20240510105843.qp4ns4y42bikfeyp@skbuf>
References: <20240509235553.5740-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509235553.5740-1-kuba@kernel.org>
X-ClientProxiedBy: AM0PR01CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::35) To DBAPR04MB7368.eurprd04.prod.outlook.com
 (2603:10a6:10:1ad::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7368:EE_|AM7PR04MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af617c8-ee82-4ec3-2415-08dc70e02a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poNkGna6+vrYzoCoZiwrnh3OE2P00bEJBZTnRbE+nxs0HcNuOwH26tsBuFRw?=
 =?us-ascii?Q?cPMx56n7XWxZIYzRC0U4/rY1gbreH6I0WgL/oMTfxo7sFMklkzmPe6Q+g/W3?=
 =?us-ascii?Q?+S71ITHsnQxPSdbafB8PPhx8+FGyXzdrpRn57z53KZ0s0wzqjuNLK2SDDyFj?=
 =?us-ascii?Q?YlOrv2AjDnD/0rS5lGtjnlVBAl0VWL5IOTaPDFGeMZA7P+0ypPUhOn0LLWUI?=
 =?us-ascii?Q?FXDtI/ARPDZSgBErCgtAUKgfMXhVudonoBk+iBtlrL8EpmXQAdVtIfLduWK0?=
 =?us-ascii?Q?wmFGFdiDvSjq1jS5zRWybNAi8o0hxuXrrak3MpMJ99OMjMGjhSqQ11zoNBeA?=
 =?us-ascii?Q?Wnek1W271D+XfMVBobieVK48qjIte5IUNYtvbbZrB2kRipf34TzgSaYEoJNN?=
 =?us-ascii?Q?USgXyAE49FZLHZb+3mnPEKnsIr0u8X1uYKUG1onoqZXi9+2rHcIoybJS4Q34?=
 =?us-ascii?Q?2rZqN/g3NF4Fu0BXsqEtBSieMQ5ZSrgz5zKXr1FcKF1JHK1fOi6W4hXeu0d7?=
 =?us-ascii?Q?BL1LkCc1htdciBCNLi4FxLbWfpnRxxbAOND5KuJuRTPcaWwPxcgM1NKfAd68?=
 =?us-ascii?Q?b6Q3E6rL3TNRMNxDNVNoUZlB26juncko4G9SjdkhZOfB+fSevstX0eY5ilaH?=
 =?us-ascii?Q?flsIdl5f4pjAvT/jNdLUqLk2TfduHAF3Cwo5rhAvBvtzrxVcQtSbHHMRnghR?=
 =?us-ascii?Q?n/zi5q8Yip1cfgfqYTzH4FasDI7rBav3rOIcprmUD3p4IlRqAAB1ZXeACfKQ?=
 =?us-ascii?Q?N1lB4x7AZglxSiS+8F2n7Iit6mQijrayZEASAdRlRtDQlZLqQoIY1/L/7knY?=
 =?us-ascii?Q?hyc0brLLf4glamQXMYbSuB929s3iklvzy6D4I8VI/1vJRC0R0liiI5/1t8An?=
 =?us-ascii?Q?weQqgdxapDtCHl+l1PqbFmr+EWpcbMJwc5hYmrdd/WNpBJqIJ0uo5V9qDylv?=
 =?us-ascii?Q?Z5Nv/mtUbE24LQUmQ/RPkPaqu7PXgf9aaebwwzNj2OuGOS5FZfySQTQS8v2Q?=
 =?us-ascii?Q?MCbddVx81DdqQuOKtxUl3uqre7ySP8gDoFcO7JgvnvLT1ntgbTNAXxG1LpEq?=
 =?us-ascii?Q?LI0CUqja8d20onIkXdmV9PRLUGEVB3PJhTINpoVkBEDtEejgBix6UMeYX4Ra?=
 =?us-ascii?Q?jHRfoUNhq2sQ70V4+s+l/JrL3mxsQWvRszULTnmKJslj09bceOmu/6tkdsHb?=
 =?us-ascii?Q?HeAfhYiLshbqkkHi+raFbZaCxvzitNE6+nOVSTEf5H61mcSMWCtOIreABnMk?=
 =?us-ascii?Q?g1Gu8jmgdG25QbPoRn1SP73Uuh9/jRRxXob/jMqUHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7368.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9er22CA3eBVVAcUTQDQBktyQELaVjMFvN2TRGLRs6yxpRYqYlxynzUYDZ2Qx?=
 =?us-ascii?Q?/7rqIcVz9INmQpqYREZmU0Pu5NdxPMuoK5nhrphoNDmzPZz9bRKyJHL/Lc3H?=
 =?us-ascii?Q?7O9ZWPq45aylk6OtW47N9tIUNqCkYvmW9Upq6xG6StYNJrQUzL27nrQxEW+i?=
 =?us-ascii?Q?Tpfloryzz4sfv7EDZxnKn4MbybNU67GDVmW2AlebRI+03oqY9cfbOLQIpbf4?=
 =?us-ascii?Q?ScN/Sf461gRLiwV3A2pF5mDQ8UxbVV7jVBoU5FyKFdaiaMXQ/dJxoNgT9dzY?=
 =?us-ascii?Q?oTLwlstFH695v+gvL1k1j2R79mRFmMFoTxYwCVfvvDbxz6w3kQKF6Ua01h7/?=
 =?us-ascii?Q?8iGOrdYVp7hJqvduJ6k7QLYO7L9bu7VBp652zoynZzeyYdk0CJ17W4GPV+l/?=
 =?us-ascii?Q?J696qrbTIY2NaL8CsNg0MhcQdF8C8bHJIVaU2x1YQJjLskh/L+W8YdFexv0U?=
 =?us-ascii?Q?7hvN2TjStLR+SW+MdRhVs9+KXfIq3J8dBcevcD5MFVvgRodrT2LBBvjBSrJA?=
 =?us-ascii?Q?lvtiJwpzMj+g2JGshMoz352ULPHiT41KxS2Lr9vHlXS+w9twpmFUaM1rcko1?=
 =?us-ascii?Q?5RU0OcccR6ZVKzcvpazEQAhCd5F57SJhj9xvh4q9R28irdu9dxN2uqgtXUi9?=
 =?us-ascii?Q?LmrCV9Hi2H9Y/7msT0Hu2pLQb+yjjrKN3StLNZyLguHwYA/U1G8zgUlJcDg1?=
 =?us-ascii?Q?LDe8/UKT1a/5YgkGBD1o96MZQqWCbfSayCYA7vQ/gMJg6PdQaAkL4I1k9DH5?=
 =?us-ascii?Q?JyB65xwyOuIh7E0NqTRChFY4iLQdweyBRGv9TcYOL9O4zrmEJGJMv/9D7KJ5?=
 =?us-ascii?Q?ae0SGGTe2i40QiUOg6zx13c7Uo48o2kKlkJMOg2/7uiSpb5Pa0UKRJvxOhfj?=
 =?us-ascii?Q?5EOpcZojv2j9ET+AKMfI7qyK8Bj/MKUqmqsBYPlYlRIQXHXDut4alsSgUI/h?=
 =?us-ascii?Q?bh03iBPA+5TA2Mf9fUsblfwktVFZS5xk0vBLmfwXv7A5pNtvIGsj1Slyibxv?=
 =?us-ascii?Q?xaA9MPtCsdYDdMKgQxplyDDSjsiRMWs5u1vlXc80TWAfRjC5ByvClFavV8hD?=
 =?us-ascii?Q?CdWoV3VQ5Cs9cqXUSVnnjLLdBMyxxYcqYSXMeaZTbcx+fNiKetdtJEr37U42?=
 =?us-ascii?Q?C7ekouoqJtkPG7nnrnNJTmCpfSzblc1AVmZRFXbmkwXmxaLPFOeIZiTG/P9X?=
 =?us-ascii?Q?WS6TTiuuZuIp0ZF8IFv71pFb+tpQuo2ttXjcxhUOln0TltnjEAsS3O4Xe2aS?=
 =?us-ascii?Q?Rnjq4rA2ayR/CjO3K0dLDa631qDxnnI5ouzVI6tZ7RTNWEgDStnFj+lQBQoZ?=
 =?us-ascii?Q?IdP4FQnV1pYre5ZLgGDRJ5as0Y2FTIgdxkjPEruRmB6ryIizdKF+pWaF7syL?=
 =?us-ascii?Q?OETD+M/5yMB919NHxT5nF9TWddppJ4a0s39JXWN30tzCPneVTtTfQ3db3LUe?=
 =?us-ascii?Q?7b9mN8w2XaDZgtwbAZyxkThE+v89FlmbeIv3vH2uCTBAzX1neqMZlI3KZzkL?=
 =?us-ascii?Q?AqZToDAOmVTan2JR6GET8COC9s8mboU+RroJkYI57kSOcPGLcfriyizTFGKZ?=
 =?us-ascii?Q?piyebkf9BA3jGjWpGJmpREoA9ossJgsyrL7m08XYuyiCcInphNz/CgtWOV90?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af617c8-ee82-4ec3-2415-08dc70e02a8e
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7368.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:58:47.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqRCz38Y371emFYE3Znyo4XFoZJtzgVpql+s0YwM9+RD6Ojk0DxtldsRHqGlQHoKNlzGdSpfYyUblRQRG7hvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6856

On Thu, May 09, 2024 at 04:55:53PM -0700, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
> index c5b0cbc85b3e..4bba9c78db3e 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -73,6 +73,10 @@ check_rcv()
>  	local pattern=$3
>  	local should_receive=$4
>  	local should_fail=
> +	local xfail_sw=$5
> +
> +	local kind=$(ip -j -d link show dev $if_name |
> +			 jq -r '.[].linkinfo.info_kind')
>  
>  	[ $should_receive = true ] && should_fail=0 || should_fail=1
>  	RET=0
> @@ -81,7 +85,14 @@ check_rcv()
>  
>  	check_err_fail "$should_fail" "$?" "reception"
>  
> -	log_test "$if_name: $type"
> +	# If not a SW interface, ignore the XFAIL allowance
> +	[ "$kind" != veth ] && [ "$kind" != bridge ] && xfail_sw=
> +
> +	if [ $RET -ne 0 ] && [ "$xfail_sw" == true ]; then
> +	    log_test_xfail "$if_name: $type"
> +	else
> +	    log_test "$if_name: $type"
> +	fi
>  }

I just wish IFF_UNICAST_FLT was available to user space.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

