Return-Path: <linux-kselftest+bounces-3259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F9833084
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CD0284550
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0858236;
	Fri, 19 Jan 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIDy5u1h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436C5465E;
	Fri, 19 Jan 2024 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701397; cv=fail; b=mK5lj/L+Xo/o9cBySlzuPkaZrxG2ZBFbxpXLagjc2iqK+UdACV+5UJ+R2ZmttcxmBHfOkPFPXsZa2oBtlxA0ST/z/G22OvrAN9b0xCX5dMb+dB+7v3hvPyXywAaVgVpDilRH9rlzWDQsWiMdgUGKmfSyv3NpYKDinnpDfhTikPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701397; c=relaxed/simple;
	bh=PkEDZoHvHoi8IIVUBjaWljwEsyrac2V8EMhZPnTM4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eu5/ANB7U6+YEai5p6gqHrnkBG4rEYS36mzpzjFUotUnokXi4ENERfT+iEJ89xdxjgyZCmBxynXutG2RbxS7Rw0tVW0qPFzbRVhmZKIpC4UCOSri5+wj5So90F9XjMoVxUpxe/k3o4YgGaQdrTXk+4DoH9PXdMNWWalC7C9vafQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIDy5u1h; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRPwaWQRuIHZg3vVwo1MM4Y0wuT3/8ZfOJm6y2ocnP6+ZBMx86FjeD5xdNOoYjQddpedkdIG0VAC+iwuJHJo8yu/qgpyLFvUEBc0DXRsGYcB3eT/GkEx09Xo1dQjI0U+P8zn2Msf+8E1KXnfDbEONpKtt3sdnEMUakXHli16I/6wKicikjCQoTSW6VfFIgB/ZlbDKWI3uJi4A8mdbE09ua/5ez8iF0EFGlRQ837dx5knAskfKAxPYAIoc2QUHoYdsOtanOACdIUfOLvnx8vsOQByxWnMTMvbxRpy6R1Creg32kmvfgDVQbrFi77QECfWgGM4QIlfq/khlFDCJZg4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Lwc+90o5O4S9a5gk2x9E8b9UM8jARe4nQq8L7x7Os=;
 b=I8zARR8FzIcvyP6eoZD3WPOWBJSiTLeR34ISQmCW0niT94cVu44DUCQyynS9ati4ld/ciAt4FyKY6R6e/JeP8qU8gSBYWFTaiwYVG3oagd7mXUKJ6JroA9ADnjKtGfbiEhVZ6tf6L+T8vwmsHyvm6nVVjTPi2JPBtN4zVpPQ3/HflMAjXQRydGhgPeYXyy/AzXmHm12kv/uKfHBOfAGF+xh/hErk7fLzxDt68M2TZvEMwL2kD8aVXWJW77occQU/HHQrtFycZpx8vz4EPxgPY8kpu7j1OG0wtQFZfJXfJRmWet7NSxr1d2GULZsGoK1palFwAiSwTq+ROvqrkeWJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Lwc+90o5O4S9a5gk2x9E8b9UM8jARe4nQq8L7x7Os=;
 b=aIDy5u1hgSOjZd7fJNWkNL27X9WxB58a3/N1g33LogMJl+i1Lc80KVrUAotUZeqNR7bWZWleUX+xuvH4f18tUD/qlR+WNLobGKsajS9OImU1r6NcW99jfRVA7bR6jKdSScSbxh0YkuKLLn/DrOkThH96ez5WiXTCTO4Z2yUlq5kzwSxfvQ0YkTJDcJBPftUqbbaFsKwio4XRxu7mkWS3rSAxRg/xBXQXemWVo7dkq6coGbVlWNnXHCBK3jV7XoCDCNFfIISzbqNSxLkdUoiymhNimVKhjWHZDQY40h+riK/FUjxnA4IUx9mrnD22x3Gns1UdnG5jVesmk1c9XjJ9kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 21:56:32 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 21:56:32 +0000
Date: Fri, 19 Jan 2024 16:56:28 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Joachim Wiberg <troglobit@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: forwarding: Remove executable bits
 from lib.sh
Message-ID: <ZarwDNeEgeJ529sW@d3>
References: <20240110141436.157419-1-bpoirier@nvidia.com>
 <20240110141436.157419-3-bpoirier@nvidia.com>
 <ad0a8b8b04a6c767942cf0d89e8048c349175995.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0a8b8b04a6c767942cf0d89e8048c349175995.camel@redhat.com>
X-ClientProxiedBy: YQBPR0101CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ef28ef-48d4-48b0-7b9c-08dc19397f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eefPLz5AVsDA651D7QCqINVwgRY4D4CGKzgbsgv1QaHwNIfAkfIYOwKs0SC2mO//xPKfHY1qBubT1azyEJ/3i2U2FyoNQYb15hxd95k+YDTPhCxUPgN7l5o01IGk1e7hVYIFsYsEyhSlfTCQtJ+DLTe7hvxlvpZfvX8pIKUZB2zOqhtEFgv9RnzeRVS5U4JpAmcIPXzkxF6X5yPExfD+bH3k5Yp89emw5ksD6+Hta0ubifS3qelLMNO5kqAVgMq81IneFu19pCOuIDfvpmKxLG/5U8wRc2nbNo/pXk7zRPFvEm/Yna/1VQ7NGT8HXXYF3RRivDpkj7FDr+3wWlp6ZAf50HP5ePuRTpke/SsR1xXQZoxaCVK/BQP94rzdQ6YiGDHj8j9lq1Vp1Rvd+UurNienX6FC+jc2VbZSPE/0mJ8VwFUKbhzj6VRz3PwJc72OxE0K/MkBttyo7RZcH9WfvP2RuASGV0YDUZolj+/Zq39X3ZWuA7zbxTMMhp2bX0Rwmgh+QDShYITWEp30RNcJjcYjdcoQ7zS7Tl926Mqt2bdITeITCEE6qVCLEEXYXto2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(9686003)(6486002)(66556008)(38100700002)(26005)(8676002)(4326008)(8936002)(33716001)(7416002)(41300700001)(6506007)(2906002)(4744005)(54906003)(66946007)(6666004)(66476007)(6512007)(478600001)(316002)(5660300002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?boKES8Vo3AbM+8aKHe1K1APAPKI00HM1tDwtOsEmOoGGja3D6/W8bFIOMqz1?=
 =?us-ascii?Q?ORCXFvZSb2HnM/RKdJIYX4QG5JoK0ahUDSllnD+F0eeakRUhMXiSsIziWvAc?=
 =?us-ascii?Q?rh/0oFydvg5cgGtIMTnt5Tzptc6IAIricnahnb2X32E+8n9WDTHCTIubwIbN?=
 =?us-ascii?Q?SRIjrZlMpMp6553ypXYFkkwushdvoNV26XY+GcWXJ6qotCSSLfFbAH2qkYMS?=
 =?us-ascii?Q?n1k7bkglB6dtJglCfH5zNbfyTbqrq+Uun5iUKTy7h2H+pSVhQvzoau+TT8Fk?=
 =?us-ascii?Q?/bkPi0DTZdXfscLiqvTHlPU7JYSagKqSet73qRRct61XTpr92iCLlp+2wNFE?=
 =?us-ascii?Q?PCLpfkGYp/PPh/YF7whVfV6Fna2t75tN1ktpG5/Y7xt9PTHZQPAzLW1uw8tX?=
 =?us-ascii?Q?MLz7kY0Uvjrh4kuagxKrieY0KUuMhJw8+CVhTm3biXqhBSKlM739qHHfHJ1o?=
 =?us-ascii?Q?6jzWEFDLbTFJeHVzuIOWI5dlTIsLbzE2SNb0JB7iHg40RwodQpErObxMaQ+C?=
 =?us-ascii?Q?jZbw1N/lN1DSYsVp7hyrJSRSlsrPh5BpxsOnB4yp8CWS38i3otxN7b5ebQ2G?=
 =?us-ascii?Q?sCx7Z/nkX7klS2q4NhwuPIFOKlaCoPSfonQ39GGN/Lr2ekreAJET7o1KM+uA?=
 =?us-ascii?Q?sX1fZzVkL9HQsCQuLkh71aOKzxfEfgiti3LiHOa/G6A6OEUAeO9MS8jgBuxP?=
 =?us-ascii?Q?dsACR8fBdLesk5MoBUF4fpWyDiIo2YmgR+j5SAWsQyolqyZaxlmRAA2HKPgR?=
 =?us-ascii?Q?r0GiVdKfgKLEYWaxlufAl/I3y8+qfV6YowmGG0o4VCAg5O92UB6878LQuHQl?=
 =?us-ascii?Q?67vMSNabdFkMaz1XhW76mvtZ/nU/LNytj5+SNU11gqV+zz1mStrd8ZtszS8C?=
 =?us-ascii?Q?9eOFCcTRMhde2RvnurK++uJice/o5ImvuglgSoEonFsVO/rIL0Jp86NcgWTj?=
 =?us-ascii?Q?6s4bxNMAkp1BPT7Yqm5oKYUZyWr2WvtYhLmdQfOgxT6ex0SKZm9F0oYqhERM?=
 =?us-ascii?Q?Bx7u7n9Km9IAlN8QZExqh38+vUQqValFZ05rpQ+7ZVIm0zn1gu2s1vDLbuqt?=
 =?us-ascii?Q?PaCt6CNeCtrSeSCrhKNkIrcWb38Yv/lCFKyJQoOrzpzSTqn1tQcvB8c60+CY?=
 =?us-ascii?Q?lY1kDX8oprizG9hH2GPeeCITDYqFuaF4pA7oYJBH0KRt3Wcy+xeUFoc6Cm0s?=
 =?us-ascii?Q?WFYvU2jJT+CfFgv1TOtvICsnQxxAJmK9gimajkXa6TEGvJBFE73ziW0EMJwe?=
 =?us-ascii?Q?10Yn0Hfb4X9ZuHa+jOP55kaX5Fbn1efCVl/8c7//dF3HJMgZoF/WNx+Cqqlt?=
 =?us-ascii?Q?YxAAVw5kZhf6M6hmMz0ZW0I1b7HiTTwQOW35EuhYTiD726Q5w0sf7iRrEtxS?=
 =?us-ascii?Q?otmb0a65CxVytbP84ZAbBJcx1BVrrx0cbRRUTNC17+QIDOQNbrOyuK415vrZ?=
 =?us-ascii?Q?ymKFLyHZqyLm7YiNYk+UaXAlXxS8w6awK6XBtLAhTlsvtgy0LEw+sDtN7r7d?=
 =?us-ascii?Q?qKb58ibhot5EhPEI4+J1ZvR3YYcgoBzwExn92dLljQO4LsgmSotePbYFUeyp?=
 =?us-ascii?Q?xNYRFIOdg8iHIegrZuQvmjNJGKp49eUfGW8dFb9q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ef28ef-48d4-48b0-7b9c-08dc19397f8c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 21:56:32.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqiWlUthBaN7t70VUi1UksZJuAB0cX2EZu5/YmPkTyC9pvR/9tEXV6RWMp3BSOjc3VGg8m/PRKVskFzfKg1LMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On 2024-01-16 09:32 +0100, Paolo Abeni wrote:
> On Wed, 2024-01-10 at 09:14 -0500, Benjamin Poirier wrote:
> > The lib.sh script is meant to be sourced from other scripts, not executed
> > directly. Therefore, remove the executable bits from lib.sh's permissions.
> 
> LGTM, but there is any special reason to not fix the permissions of
> other *lib.sh files in the same directory? Could be a follow-up.

I just looked into it and as of dbc153fd3c14 other *lib.sh files under
tools/testing/selftests/net/forwarding/ do not have any executable bits.
Did I miss something?

tools/testing/selftests/net/setup_loopback.sh has an unneccessary +x,
I'll send a patch for that one.

