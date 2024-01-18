Return-Path: <linux-kselftest+bounces-3177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA883106B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 01:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132AAB22898
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB1199;
	Thu, 18 Jan 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sVSDvI2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B619A;
	Thu, 18 Jan 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536971; cv=fail; b=W9d3hb+g0nOBH8k0oxjxfpSwp+z+2Vm6b2pWzkTeJELCZXn5B8kmD16HYRoNkyrIffS0CTzdM8uXe0dmHyq7/F3s6LXkX8eRGtx06OWyKAKpJBEDq9d30nkjDY+S+zqxkaxWA/+bCGd9aZDss1NBjednjNLexgNyB9eoX6JAku4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536971; c=relaxed/simple;
	bh=wp6GOaaI4R7rCC0a+ODrc26G2/1T7gDF0scgf9xhasY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=aWn5/VlRyhxpPMmLwAvpJhsJ1+P9ibya/G8yj9iN7aMdvIEMrsmP94lt/s/pc1yqf4xU5wdMBrrpKs69tuCvMzuoLJPX/6CaBXaKGRDU7p2A6/EE76/LjLdvddnQrdeXMlaPNxshEJtc8F1SBaOiMLrgPOrKLfOUKjQgwXQdFm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sVSDvI2X; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6JDep94Q2qhePKxsNk5EVKTk8RfLSvto0C4YuqBp5tpqygcuLuqupeH3LAo57TqHX855cEnsqUm3+BWRyIw8UTeTsJ3mc3tkWm7ia72UDmjoAe35GOZiWo85aEA0gBcWIK9FqhMo2Tk2QstUZ8JyxFsslcTuaYN5lkF+h+erF8OWv5un37CzhdGm6NM2o/Nqiw5NzbHJMijRoZwO6xWDVO3YZMjxXuIW0AGbucmWwJAZAycmWPTMkdOMS+sNtGmNpyYqUn6YLOOgaEJ1sY4SKVEFRt1gWkq85D83s5EeWqFp4fE4C5IoT2yQHzFWgKSHin+reqHDREKE4RMwO1CLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq5KCnznBfWfplz3c5u6QVe83pPyo7UloV8vPOrdDyo=;
 b=Um0o3qElG/tE/WZrFmfCg+awxU2qEwuYHeIBei8yXuuO/L28a3Xh8UicBlacYR6Wg5wLxtikqAba7szHSnKgMxybF8igx9tTU+8bYy2w2kYu5PQhxq2lJ8SAtSQZwharuiv3R5vO1mGL0VCHDAxJa/YGQLWIMuwIwYWdG3speJFhtvrmUHDq5SIqJGjHvVhZGZJoaTTitz3iYQUnVN8qBGBrQ8sdoggmdBN6zua67lxDX9CSRc/E0C1Q1GrdOsSvwt/PNGK+ZOrXAG5771rFOGz1agV67b+HyGW+ce//oslcx1SYgaTDGXbmaEpPhYdWSqN8TzAA3uSjuFnaIeL9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq5KCnznBfWfplz3c5u6QVe83pPyo7UloV8vPOrdDyo=;
 b=sVSDvI2X5YepyFYxSS7eaJnbuoj7vGiBCBspnNXyIws5u69aoxZkypbMBspuqVyUWPLPgtv93AWcM4toTpZOTfqg6C96XbIOdpKeM81baqAI61PaHXjz8Dd4lYFojyPUt/M3WMwCNKjdaIyi2ZM3aqHoQeDfPK2ilxlf4RUoymm0Gq/RafGQmWx2W7iuXGBIYkCGuXS3dOw/ExPAN2ZAlmNooeXfx2WHkM0quFKQC2zIxL7SRS5CDsHlT30LAVrBTwtOasSukJDAfghpPz0g5EX952o/C44d1ZdmMo5lDSCU4LDbZfMQ7UiWilXPFYi7b12mOEkPeUSzKxzkgRzvVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Thu, 18 Jan
 2024 00:16:05 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 00:16:05 +0000
Date: Wed, 17 Jan 2024 19:16:03 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jay.vosburgh@canonical.com>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <Zahtwx2NmxOyko4p@d3>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
 <20240116104402.1203850a@kernel.org>
 <78106.1705431810@vermin>
 <20240116112012.026e44d9@kernel.org>
 <ZabXT2ZepMuinE50@d3>
 <20240116112926.541e0651@kernel.org>
 <ZabdYhBRHiNt-jGy@d3>
 <ZadGZeJOc26LOJJa@Laptop-X1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZadGZeJOc26LOJJa@Laptop-X1>
X-ClientProxiedBy: YQBPR0101CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::28) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 620be45c-b638-41e8-ec2d-08dc17baa951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	265OnO41Loxu/38KrNHVOAv2NmFIfCTXgipJUplCSbT9gor9664WpA9iQP8SMtc9sGqy7Jljcg1vxap+C4hlDpY01ghIJrZiV3Sovp07tJs1/BRM1e7x2azglYHKypEk+oe7FCjbbGdzP+VO5J+kQgpgr4x/FaFyg1r8MDEnK/QvjwKUZrNNUd64pJzAwL8hcfPCdIBc8HnPseGAFH2ma8oRz1T9TXcErkaGpiqYuS5rr1IJdlmJCa2hCX46SeP/6qMSA6Uu2wtvectrDYfMEKDm+wV9G8ze3DraYNPiexMRDxSn/sQUIrWyxkQZptLxSfUiAMFRPaTgnnRe4rGvrqUbFMqhafYGOK46fYEfr96AyUsqLxZOBPhdW+Z7me2JzwL7XAKRvyDN8Y2tZo9sDWRfx0OpdIiHFxRx0OroV/3KflWRwHR+LgmpTX+Z8LK0E6EDXim3RucL/DXy2u2N5HDKxjlEoNBfdY0iXGIs2a2ba/4ExdEgocSchmn9zF+xUi8QnIy9igFiLuwbvvY7p78HsaDekQWyvmzYFcgAydSrCcUbYN6RElu8ewMaodvd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6486002)(6506007)(53546011)(4326008)(6916009)(86362001)(54906003)(316002)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(38100700002)(6512007)(9686003)(33716001)(26005)(7416002)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2sSIAZUVkm1SGt+uX7tIGVV1sasfXPfUOYfqijuNY/CSH+a670Av9bw5LX5?=
 =?us-ascii?Q?wbgMRDn62+LitfUEmWtZBBAPKvDgLHQlFYtcg4TvCK844YKmldspNJ2HUmLG?=
 =?us-ascii?Q?DSxsAiaJRnxtC0z2to9PuJrjcj2077ntMt42thOURuy/SKHAzXmezf1BFyCd?=
 =?us-ascii?Q?3Oa0TE1HKXRt0LuwPhRcjJEN7wHlYXzdqtMTrDMg6fpmgvNvnOjqh871ZISm?=
 =?us-ascii?Q?2j29HenJrkvFFxtJJHQOpF6j+yKPesN32lD1rakuDJLK+ycXph65DAMy2cAa?=
 =?us-ascii?Q?uubH3Sc2XRvr38syv179BHKIEbUWYaNhsC1rcvqmN3brXLTQed7jlnzL9Vid?=
 =?us-ascii?Q?Sr19w8VlxjIQ9W95br9aHWlWT3I4WT+3TOjcfMHqCksoYz5lcUpcbRY54DnY?=
 =?us-ascii?Q?KP8yJI09sheDinA587fRdwRYn4+0cnDR9AcWoKLKIquMsMcdQ3CEb9hc5LS/?=
 =?us-ascii?Q?f9yS46ep/ytE5Cxct9p2DhGVK5b84dkB71EX0Xr2Q+wcX8/w10SXBjF5gM/O?=
 =?us-ascii?Q?kG9n7DFX1Lv7rAV3qIghdKobYa27tOHqQWGEikoI118J2MHP7uxQm4czayDJ?=
 =?us-ascii?Q?Vb3Jfh95Gq/zG2Mn0brIvzAR8BroT5L0e9WKSOS3EkvFvTo7m9W+buB9GpFz?=
 =?us-ascii?Q?1O+QacyOPukWCRmK8GPlQLDrs4BJM9js/sRI2HRej9jxlV1+Uuku9daednIM?=
 =?us-ascii?Q?xNf7tXEKnJWPGb7evRbvpoxrtjF0VIIEAhbphUaJkJskI1Q8ugiEu/R4gpQe?=
 =?us-ascii?Q?mlq1T9fnafEbzqZjjK7b7VhJhLTf+tjXWaiqtPw55vDYLsMXd8Xn6JuSQ+Il?=
 =?us-ascii?Q?jD/shDcikTPF1VNa7Txcmnrxld2ephDMMrkXYoSIdasqr8+KrwLm/s8mawQM?=
 =?us-ascii?Q?ew0h1g2VaaxjC0oHZ9n4JbxxdlAg1PIo02TYt3GJAZkRV3o+XCVUzDvNelii?=
 =?us-ascii?Q?dvZzU7lZKqSWj4thIVWTvBHWhDnlhfU7xvom7hyB+5e6J/sVuLLDv2vGbGJU?=
 =?us-ascii?Q?eCYRWIv9EIWfZJe9R10fOsanElfElrTIlAS4PipHwhCtxye5Ut4iWVaK1oAz?=
 =?us-ascii?Q?YQJ5Mw6ZjR3Oyg8dLsLEGuzngyxbl2Lp/2DRHTjTYOwKgjbibhRkHnSZOABj?=
 =?us-ascii?Q?eB/6RUkYmwvUtTMfuvrV8Nse7P4l1okW4SvnJ7M9SnzIUYERnbtbHUf/9XxF?=
 =?us-ascii?Q?Sw3f6sSyEsNl+uQp6rQKWHC2kOepDt+SnjZRrR//e5kXVlpBnxFepp2I30VC?=
 =?us-ascii?Q?Y/V2ymH6N05DsRqTrA8ilqgRoolsIpPhgbh0LbKaYS2DjGRrRu6RlJEAGN69?=
 =?us-ascii?Q?0NJKkKeow09/BDL7eK+t/+XQmXigpPzWsdT+fB4hWUY4ZXPlO62AOT3emz08?=
 =?us-ascii?Q?ph+rVZ/bWV0AuMeZyLwnjoS/EzBYHkCW8n7srUgTmdtYt9zAh0w5TsfzS73q?=
 =?us-ascii?Q?zc620Suw3bcullZ7I10EiiHdNb83VXVXXcCmTRCTq2nI61ChHxC84dRVel9w?=
 =?us-ascii?Q?xbd96cBs1mR3pLrMYcrs1m7FAMkNfsbotbyTjcGpKcKSElE6k+T/B2AaKAkJ?=
 =?us-ascii?Q?aSIpOuuD5sCNZKWdUjDdftO0t0fMvVFRSJIKTMVy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620be45c-b638-41e8-ec2d-08dc17baa951
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 00:16:05.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM/B/TCSj/FOpC4+u8GmLTEY1LpoAyrH9HxJvC12KLCLCdQMJx2iSg5RxYlNSACs9WCqIZB6irToPKHyOp3KCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

On 2024-01-17 11:15 +0800, Hangbin Liu wrote:
> On Tue, Jan 16, 2024 at 02:47:46PM -0500, Benjamin Poirier wrote:
> > On 2024-01-16 11:29 -0800, Jakub Kicinski wrote:
> > > On Tue, 16 Jan 2024 14:21:51 -0500 Benjamin Poirier wrote:
> > > > real    13m35.065s
> > > > user    0m1.657s
> > > > sys     0m27.918s
> > > > 
> > > > The test is not cpu bound; as Jay pointed out, it spends most of its
> > > > time sleeping.
> > > 
> > > Ugh, so it does multiple iterations of 118 sec?
> > 
> > There are other test functions in the script which include a lot of
> > sleeping.
> 
> The arp_validate_test need to check the mii_status, which sleep too much time.
> Maybe we can use busywait to save more time.
> 
> > 
> > > Could you send a patch to bump the timeout to 900 or 1200 in this case?
> > 
> > Sure but I'd like to give a chance for Hangbin to reply first. Would the
> > test be just as good if it was shortened by removing some cases or
> > reducing the time intervals? Or is increasing the timeout the best
> > approach?
> 
> The purpose of grat_arp is testing commit 9949e2efb54e ("bonding: fix
> send_peer_notif overflow"). As the send_peer_notif was defined to u8,
> to overflow it, we need to
> 
> send_peer_notif = num_peer_notif * peer_notif_delay = num_grat_arp * peer_notify_delay / miimon > 255
>   (kernel)           (kernel parameter)                   (user parameter)
> 
> e.g. 30 (num_grat_arp) * 1000 (peer_notify_delay) / 100 (miimon) > 255.
> 
> Which need 30s to complete sending garp messages. To save the testing time,
> the only way is reduce the miimon number. Something like
> 30 (num_grat_arp) * 500 (peer_notify_delay) / 50 (miimon) > 255.
> 
> To save more time, we can remove the 50 num_grat_arp testing. The patch would
> like
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
> index c54d1697f439..20c4d862c436 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
> @@ -277,7 +277,7 @@ garp_test()
>         ip -n ${s_ns} link set ${active_slave} down
> 
>         exp_num=$(echo "${param}" | cut -f6 -d ' ')
> -       sleep $((exp_num + 2))
> +       sleep $((exp_num / 2 + 2))
> 
>         active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")
> 
> @@ -296,8 +296,8 @@ garp_test()
>  num_grat_arp()
>  {
>         local val
> -       for val in 10 20 30 50; do
> -               garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_delay 1000"
> +       for val in 10 20 30; do
> +               garp_test "mode active-backup miimon 50 num_grat_arp $val peer_notify_delay 500"
>                 log_test "num_grat_arp" "active-backup miimon num_grat_arp $val"
>         done
>  }
> 
> With this we can save 100s.
> 

Thanks for looking into it. This change got the runtime down from 13m35s
to 12m7s on the same system I used to test yesterday. That's a start but
since it's still well above the current timeout of 120s, I sent a patch
to increase the timeout to 1200s.

