Return-Path: <linux-kselftest+bounces-10289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49C8C74A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70592282640
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE38145328;
	Thu, 16 May 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bHnaLLSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65017143C55;
	Thu, 16 May 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855428; cv=fail; b=JW057ewV0Vpq+3/6TO/Yxjwrpb+V0j788L+EOCPVwtfx1lpaPhhRGsyVxv/MUPflYX3nTa+J1s8NGKwE2L2xYm8fpJytRf4DP5vOOY6tEd/yMB0EvLcZk6vt9aNQhtjkvvJxwb1hQBO3yPq2evOHBhpeKyMWZGN4dGRY7iWPaoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855428; c=relaxed/simple;
	bh=1tffHcAoN1464NYgw8ghPkEhwEJllg5x/OhJsrPcMVw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OX8SxKXkyZ9DfRa95zofF6aP2NvLhPBBWAxMVFhXPGJzjjgLFHR6po+Jw+Apymcdg3had+0UA0GGAEqWI+a3HXQ3YuL19t2HliLI5Dy/CogXIHZqQZGXmBzWl8Gm1jGvTFyy6ZPwL2ZBrPMlU9mTznH7xLUGDzQpkLRhYEJzl+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bHnaLLSn; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1Rp/AKzS9t7fqkPLMAsu7Su9Ulk5BWo/2ZzQXGBDro29qufslGrLFjaYF5TTBbprPOCBNtoiIcRaAIc8XA4WtiGKFTn4W5llVPghNUa4lKgWKZSTWYpLL1hsgvVt4pwIm41IIMhbr06dgWGUzFCQmzvpfeKqkW2DRa10bAnl9HjBJK2JdpYIIZoa/rOOwxj6qQ9Sd6O7QRL+i/ZZ/G5+nQHnDTotn7zsxXB8M4JFGP5ypoPhW/dIl/JCaI7g3y154iiNuMZWlvIMT15VT8j1BGJIw8mLZNsMsH2ikB0CQQgnlwpTpyTQupcbbmggZucKEJlqpMwv9ZUG3KF4zg9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coRR0y/pkc9zRs1uDhClaRbIvcinyU9R527CNQalRcg=;
 b=UyA0rdN8arb8KKcIe6udkkTkevRJbeOTNYBY0faWKAY/bVWmzJRsbz4Mlaijh7+yCHYRdimnk7kTIfiTsfra0fMT+gYa2IkgBimILYuuZk4Pvm5gbR/FkI4D4o7SzG+nACZhFTnuBCSyujvJOqx1z/HtuGvpH+V5hXLBDitpKHRWOfvsnDQQg92+uuJrEG3vJjzzDndFX6qUUjjdU9xjmf6Nzzk0QKoamVyixX7jL82ALmRyDNbwUv6pNqPol+OI+QEhs/hvvvL8Qj1ScCp9VurflghwlqlzqoiZpIBW1IzqlWBTZyuQpCeAMuVCEsoNn78Ynkwkhgw2oecduZUfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coRR0y/pkc9zRs1uDhClaRbIvcinyU9R527CNQalRcg=;
 b=bHnaLLSn/5eYlaFtNmxCp9qyLMiNSVZoyZHXnlJ9QiXdzHh2FzSrzrUYymK5DKzodxYcTN1cD7A0bUmaO07gPFzsqkseAwTBnNlNBgDS+ypZqBPuAaswJAOVLSeviNSFTzqqT6C7tQLIJbfyzWHi+m5WO+y+pKQFDgcq5NSUA39nPoKP6tpkOtLf8832kI5iw1INXxtyfFj/6h/Z2oHkq08YHo9ihr7qi0YZvkgoXuZzbY6r1y6WN8aXjqB721omJHJz7z8XSs98ezOrg/HQxDY5bRigjh7GDFES2Yl/3zLvTWNnO97XHXkmaj9ogLnfAlrp9tEygYJ5fYUaZri+1A==
Received: from SA9PR13CA0126.namprd13.prod.outlook.com (2603:10b6:806:27::11)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 10:30:21 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::54) by SA9PR13CA0126.outlook.office365.com
 (2603:10b6:806:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10 via Frontend
 Transport; Thu, 16 May 2024 10:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 10:30:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 03:30:05 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 03:30:00 -0700
References: <20240509235553.5740-1-kuba@kernel.org>
 <875xvhu97r.fsf@nvidia.com> <20240514174321.376039a5@kernel.org>
 <87y18bju1n.fsf@nvidia.com> <20240515162132.476a6b43@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vladimir.oltean@nxp.com>, <shuah@kernel.org>, <liuhangbin@gmail.com>,
	<bpoirier@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Date: Thu, 16 May 2024 10:42:31 +0200
In-Reply-To: <20240515162132.476a6b43@kernel.org>
Message-ID: <87ikzevyl7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 811d47dd-bf8a-42e6-cd3d-08dc7593301c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSVwJ+H8MCepLeTj0hMQ3h7szB6HGVHlC81sP+HAGp0/DTq/OH3u6J1Si3Bx?=
 =?us-ascii?Q?Kvb1G+6BGzE5crz98kQtnohYU71lC5tQT2JkVAER5IoLDN3FHa6KmQQKf5/e?=
 =?us-ascii?Q?WctNqyFW54i+qQ8T0ntgel32cJiNzvLyAsVwBt6H6fzfRqUdIUsWLPy2ZEUV?=
 =?us-ascii?Q?/is1A1h2sQYsUcg5WY8hyyvwStjsydZKyS3Te19u41YY4SqGJR50lCPQBmdS?=
 =?us-ascii?Q?A8zE85kCqW6v2TAIo8Ncu9lRY5KZ7fiHzsv/ge+gZEtZgLe74u4Z8dzqBx5i?=
 =?us-ascii?Q?0pJDTVx3mMPyld40mo8mbEJ1/+YoL/cfRbqMe+8vqYE5nb1BymYiIqWxWdR1?=
 =?us-ascii?Q?P6tnQWL8yfRGbGREUk3jmEaF2z1rk3K7FiaS5NMBr4fkL2+59DCVz0+jOE6v?=
 =?us-ascii?Q?6orschvTMR055V+Mmc076AlZdJdJZhePjG9R7SoezznjASo9iXJkv3VQ83Wi?=
 =?us-ascii?Q?5awz/57vrj7EtO6YzGo3IAk+9nBPPJM+3xeri75f61jAogxgsj9hYbvtZxhj?=
 =?us-ascii?Q?T1VSQiolDdNlQ/b24QU39vMaaW2ofxoSVQ/zd/+gSAKGy+hus+WusNmVqB4s?=
 =?us-ascii?Q?r5Ba+nwh6L2LSjUJXmgvnku5XBxbcNdAqK/6Bwt0Ljd/T6qY3L16JGKNx1Hi?=
 =?us-ascii?Q?qkWKlllXqHMiQ4jnHEMneYEDCDDKuB9E4XtI4PMNpd4HXsbx7AtsW7NYhLG+?=
 =?us-ascii?Q?SDb/07H+cIDJkx9U8HlPh7tAGz/Y9zdw3c51MT7fiMTZ4DmNNckZa3532Ovd?=
 =?us-ascii?Q?T6AhMJVq0OEtmXlS5OMgPyfPqyKAZZ/lq7mS+R3tDPY7mRgsfYSAhbSnL0xq?=
 =?us-ascii?Q?aZNe4ijTe5YqSGSp0yeKN9ZOoCDk8go0GcNaIaqFYl9xeMp7LSw7cdBRKTqS?=
 =?us-ascii?Q?fh5NIdK/kwj5Il7ML+XmLK504X8FfV52A3oo/RAf/9hHlHjoDpsxnGJXA6E/?=
 =?us-ascii?Q?Gcs1L7CS+jEO17hnwAA8UYIzifoh2YytUiCvVQlA6730FnZP+wpr4eNyIcaF?=
 =?us-ascii?Q?kp8yIdi2um5J0A9/OMM8/KEwarUWpwLiVHpyqdtQMCpVF50nfwgOYd86YBKs?=
 =?us-ascii?Q?BW2Jb61KWLhV5MMRjb9zbe5rdwLoDUgWy0HtyCW6xQyatXiT6voisG/L6V0n?=
 =?us-ascii?Q?FTQCvDOGJcsVWeYNgB9KNRLIj+CEM7OPE9xHQrNrN/EPPXnCFqfML/FONgoq?=
 =?us-ascii?Q?cAXTryX0T8QdAFoJnXrMJUzXZUFlcVhWFpQcCRZ1qHWrVM19lNgb0PRLK7gl?=
 =?us-ascii?Q?pMoikzVavlwW/5E4q8PSbBerhotPw/T5ENh3vzv3n2KEtcR6vyaXMt65QPbv?=
 =?us-ascii?Q?FzBNkNcaJQOz1jfYbPJ5po3JLTPXodykMoCIPdCoNdOzs+2xefLX2qqOgCZm?=
 =?us-ascii?Q?nviP38T4A9e+rUYyPMXU1rrJ/h5X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 10:30:20.5885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d47dd-bf8a-42e6-cd3d-08dc7593301c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 15 May 2024 11:02:28 +0200 Petr Machata wrote:
>> >> And then either replace the existing xfail_on_veth's (there are just a
>> >> handful) or convert xfail_on_veth to a wrapper around xfail_on_kind.  
>> >
>> > I think the bridge thing we can workaround by just checking
>> > if ${NETIFS[p1]} is veth, rather than $rcv_if_name.
>> > Since the two behave the same.  
>> 
>> I don't follow. The test has two legs, one creates a VRF and attaches
>> p2, the other creates a bridge and attaches p2. Whether p1 and p2 are
>> veth or HW seems orthogonal to whether $rcv_if_name is a bridge or a
>> veth.
>
> Right, my superficial understanding was that the main distinction is
> whether p2/h2 can do the filtering (or possibly some offload happens).
> So if p1,p2 are veths we know to XFAIL, doesn't matter if we're in 
> the vrf or bridge configuration, cause these construct will not filter
> either.
>
> If I'm not making sense - I'm probably confused, I can code up what you
> suggested, it will work, just more LoC :)

I'm not sure myself, but from the commit message it looks like the issue
is with $rcv_if_name being the bridge.

But the patch that you inline is R-b'd and T-b'd by Vladimir, so I'm
going to assume it's doing the right thing.

> +# Clear internal failure tracking for the next test case
> +begin_test()
> +{
> +    RET=0
> +    FAIL_TO_XFAIL=
> +}
> +
>  check_err()
>  {
>  	local err=$1
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
> index c5b0cbc85b3e..a241acc02498 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -73,9 +73,12 @@ check_rcv()
>  	local pattern=$3
>  	local should_receive=$4
>  	local should_fail=
> +	local xfail_sw=$5
>  
>  	[ $should_receive = true ] && should_fail=0 || should_fail=1
> -	RET=0
> +	begin_test
> +	# check if main interface is veth
> +	[ "$xfail_sw" == true ] && xfail_on_veth $h1

If xfail_on_veth $h1 is all that's needed, then I really don't see a
reason why not just do this:

	check_rcv $rcv_if_name "Unicast IPv4 to primary MAC address" \
		"$smac > $rcv_dmac, ethertype IPv4 (0x0800)" \
		true

	check_rcv $rcv_if_name "Unicast IPv4 to macvlan MAC address" \
		"$smac > $MACVLAN_ADDR, ethertype IPv4 (0x0800)" \
		true

	xfail_on_veth $h1 \
		check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
			"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
			false

This should work now, in much the same way as this patch, but the intent
is IMHO clearer (vs. passing a mystery true), and FAIL_TO_XFAIL is
cleanly scoped and doesn't run the risk of leaking out of the test.

>  	tcpdump_show $if_name | grep -q "$pattern"
>  
> @@ -157,7 +160,7 @@ run_test()
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
>  		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> -		false
> +		false true
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
>  		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
> @@ -165,7 +168,7 @@ run_test()
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, allmulti" \
>  		"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
> -		false
> +		false true
>  
>  	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
>  		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
> @@ -173,7 +176,7 @@ run_test()
>  
>  	check_rcv $rcv_if_name "Multicast IPv4 to unknown group" \
>  		"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
> -		false
> +		false true
>  
>  	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
>  		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
> @@ -189,7 +192,7 @@ run_test()
>  
>  	check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
>  		"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
> -		false
> +		false true
>  
>  	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
>  		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \


