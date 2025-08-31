Return-Path: <linux-kselftest+bounces-40380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DB4B3D428
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165CE17A387
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6926CE26;
	Sun, 31 Aug 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4qoJAiW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABC1F4CBB;
	Sun, 31 Aug 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654569; cv=fail; b=jPWVw3yzy2vwmjryjMQvCCcltBuhr0b+16QNC8nutjJ1stEDebNndF3GmwiTIxrsCK+rVYOm5LsYYb8Y3lVeJJmRP1T04RBW8RGFK0D6vqauNVYAMAnRov8Fehgq3mWQ9lOnzQAiRrYElZ1exISRZpZQEnIH3n/tQyWogL3gCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654569; c=relaxed/simple;
	bh=MAXBn7V3CPpyiGZ3/VZA1vlNCvbjakV1ItBztk8SZMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ah+5fJTULTb4abCq+QQpXpTLnI1iojYCDKSoj5vANenHOUZpwvVikBSmEFb/9PGRMeQ5hBCsrfM9Htxaou+NnmQVQS2ukZxB5oI7VFxmIcZoICOtdmfi38pE7EoVe6mEUlPz/YL8s/dkG2cv20mFxSECi9iuIzGNuRjOqV9LOUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4qoJAiW; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke9KvoDFfHQKz1ixdF6E9//q4hAmMDDR7aNcrL6hw8hk7c7HcZyNVDK8W9sTLeFNRkYzeE5WvAeLsI7nIL29XQg+fG/XRIpDvWK7ltnPdAsUfMWzGy7y1eECN6m/vePR5MpmpJPBsjHzyEYXgJPZ3Ol0tE6LrZX5jGk9ob6il1J5HL59ptCoqpqMMOdS1D6Vxm726RVYls5BsOdHr4L2mcp+9NiSYtUsonuQ11xiJQahkFLMKqM1S8isUaB2nJIS/xuy5OYPeXAx4OZI6cvo/gLYmzj4LM+RJiWecBHvE1KlMbUjQTMHYbQFrmdNy3K4Vg7jJ+NcJ5MKyoTyTvDjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg37BFB2T9p8XtzlfB94utt1TpaA7SdQzEygxVAQ7Nc=;
 b=xVEUdeAJ2ivgCzWVrgImWGhrzZ2E1nHtV+mDwXgIFuqz5qhCmug5wTIzd6FrW9+EV7z06v8f41uzmu0C+q0QTMjMyim8jFsyPz/r4f0THOhOMMog4CN3lQkdWETcqpRrWT6s7kzt7Kd/9EE0iWIk3wWCZxZeLHz/MXKq22uW3qfC/UBcpEbMccp3pjOOsMKR1j0qB1/JnSY8tTjRxK5Ru0tyhi6ttc0/nrFqLBhLfjN5nR5D1lEhsdbug3U31rxlAbRhOVSF3h4y+9H0UZ4j6Z7idLtVSmB4KgL+RUKbnmcoxmPt2Emsns0MHrS1Ms54IXZPNVlSjwjz7ShNsIwQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg37BFB2T9p8XtzlfB94utt1TpaA7SdQzEygxVAQ7Nc=;
 b=T4qoJAiWrGU0OznfvPFhOl9xNkDA2aIo/o52yBujrnTSFbsp3ecSadk3sCZy51dwhHRHwyh+G4HDMVrucMusqidTVd3SM11Cerkv/y2KZkX8XcQifFSxtkB/oGP9IRNZcbUiAlJ9PdWE+Qm2hoba7HJDpOLDOnE4G8qYEAqtbm74MIJQOxvtWnm8CMB1rpf8gu+TxcG+g8GapjB6tSptpGrvtV/RU8GHitk3V/GBLW10K8XnWRYaEqXZ9pYzb4M0ovIcWUgqJlGD4P18n28H+Vu9RVc1f766++yktO9B82PiKma8m30iwJo+qmpRG3JdfMqd8Ea2gC2INaOXFYeCWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Sun, 31 Aug
 2025 15:36:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 15:36:03 +0000
Date: Sun, 31 Aug 2025 18:35:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aLRr1W3jKRDYsRSq@shredder>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829095430.443891-2-liuhangbin@gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a5dad8-bcf4-4fee-8314-08dde8a417ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdR5oZ+0kBDGeOjpTMpJ+RC6mmiayrctmLjNnW6sAVdcg1GWnpItUNhwyuTe?=
 =?us-ascii?Q?KbuYbAP6mPNI2xsUpMi2Fc9QL1/b4unbbnqV4GthtNuMAAEjoxCK6+2mWM5v?=
 =?us-ascii?Q?69IaX8dBkrxRJa8TyF/GA7hakkmkN3pcI3JPWE8uARconZ7B7x7Wi7R8KYdJ?=
 =?us-ascii?Q?ZV8unT2sHtwrEhtzH2ldI221X+Gr+HH0AuBCJlNjrQNuUNnywiw0YXUDK7tb?=
 =?us-ascii?Q?M2+WwGgjB69pWK7TVwwpLHoV/aQP6vdH/5O7Dzt0ibVB+hmO6vMX1WG7dQDo?=
 =?us-ascii?Q?mT+ODwYq1FVV4XCY9/SQ8qKNzHklzCRLTVU8SDC47DeluDh9gS3Q2PVRbeAI?=
 =?us-ascii?Q?5S5EGFUK+OSBZJwjp8K6nXASA/vYJ4vMaPrp2EBrvSDzuJFJssFAuAUJ9BMk?=
 =?us-ascii?Q?SpEp/WEaEsrmmn82u4lC1Gdyrx8ToOngYGxKYyeZZljgFVAXuIjjbWYk/8vD?=
 =?us-ascii?Q?OcnCwfgo93v2lGZNDdgH/5lCp1J85ogs3TgHQYLe3N1iPMCPUyB+SOdXHDN/?=
 =?us-ascii?Q?ThaY9gDpHgUgVhlxgPCEpnQfBFDBpy2CG4js3Dc3uG5h4Bw5Lb7/h2967wBK?=
 =?us-ascii?Q?zSgCYlsf/uWxoSxKQCgjqlIKXgaWJ1u/uvnGbFioU81auB1IpnjwhmVbpy1p?=
 =?us-ascii?Q?0yJlsoxGdLX633EHY59i1yGPQDDEIotkhb9SSjBswt2azacMlixVbE8mSFfz?=
 =?us-ascii?Q?a1AJR3Fp4K8JzoPuXzWYpEZOCi0Dk06TMn1eAVN0gZt7X3Niz0LK2YudsHrl?=
 =?us-ascii?Q?qJZWif4RTORqF7qH1amGLLs8uh4VWmSz6KhiXq+78ifpO8huPHPoe3+VkRtf?=
 =?us-ascii?Q?z4Z0vvxRq8dcg1HPj3DbS2ZZwcQzdrPanH+GCAGXs9P91aBLpKqMV15qWeNf?=
 =?us-ascii?Q?6RhGIyIOSgoDJrtjZEUmN0ggGgOU3vR15qZBu3Xz80MC/0ZdXMTqST0lefDh?=
 =?us-ascii?Q?3rzx1yoyBm9e7rC3dG8ca7IAEaozr+QADPlA2cVaGdHh1dYLRJRduO95RA1S?=
 =?us-ascii?Q?P1OA15ktvYV9oWlJROfnvP2QMCUoL2Eo79cEztk0YMcl69Gjn0+xb8va+P0n?=
 =?us-ascii?Q?ZdJEEglnm/kCDu19OjWpgde0TtIYeBuJAvyGl4revpmM3PWVs2/IxmeOkhO0?=
 =?us-ascii?Q?+rag9RW7swHRgR+8ngOwNzlpvTLHc/nCWLQ9HSa/AF5JuS5ivprB3cBOJ4E9?=
 =?us-ascii?Q?MRHmCyKCSVJXW9u7oQVgX086yZdfCvC+4cnfzn8qGitkQUX1IKkdzwQbkkFy?=
 =?us-ascii?Q?gt6F0AkLvod3oVLddkfQo0NsyirwIe6Ca+tzZKjHkCAfswvC9m8iEBYEzmlY?=
 =?us-ascii?Q?Br8amthwR9SIsuqN7bW24rHcftWnFzCZ+Gy15aLJbpbv2JCq9TwZ/EC/QuYd?=
 =?us-ascii?Q?15WxOSrVhLmNUwBe7y25FdJ0/oC1Sg+A2ZxZAh+D0THIb6Er1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18lN0jr5S2k55y2O9xuUlN/8uyWxrGTCoay3KWkARiDHuIJHlN6O+Z7iEsVK?=
 =?us-ascii?Q?SfUVZL9ZPP/fXzDl2DgbpEvbSAjR3e/EAOohmocTMrmkZONuDsCm4XHPBdaj?=
 =?us-ascii?Q?Ba9urskcmn7eyoxKARt1uBWubiw4xmL6dRtzxjT80w4iXzahM/UnVbrrnk0H?=
 =?us-ascii?Q?e1/WAVYIY+LiuYd9Tk6kswyLaD65QfWuwKAOFIlSWmqZNV1ZBMAPC/oMckGz?=
 =?us-ascii?Q?0XUaYdGE/JiBdKynSjNgTR92F69SN74o4BWPMYw9IE+jNxHFTZefTYA2KbJ2?=
 =?us-ascii?Q?YnIkPNumILNiobyYRpFiaipzT4szN/NlAz/5VrBTxZv1gVDxahWdSHYozyk0?=
 =?us-ascii?Q?7Y08qfi5S/5BZ15s1pZ9MDFqStpcDtmIL1EtUVNmgzOp+2FXTZNRaQiXUAQj?=
 =?us-ascii?Q?rBZeOA5W4+ScEFUldCXxaSHoTPJI5+/tUDB/CG+3h3ojOSEYpBBGlOVi+ie7?=
 =?us-ascii?Q?lUQAUV7rfalcOdo6dnObKmTtKPpiPCKdT8WNurqTtX/IdTt20OVzE0d8UI/1?=
 =?us-ascii?Q?wEGkIArp4+AO4ScxPzjy6cvqA53YZpQ+SAvzmtQNSKmzh9Cj7CiBydtkJ1R2?=
 =?us-ascii?Q?BRmT3SNHhs0EXysHObHqqNHwAmVal8S4jGb0c3vDuADu9KKZT0mb43gqJamc?=
 =?us-ascii?Q?jkZjtKTzBgNLT3J7nxQbM2QZib0do/3+0G9dlFXGHaR6V67iMmchos+r5OVE?=
 =?us-ascii?Q?MhoWaI0lwMVeM/Sy2VXdN9/tS6CTcvbGtMPorKPpKwFa3I/gowVjMiuopjbc?=
 =?us-ascii?Q?UaIWBqDU5aRhIjYwLcWUOrib2uBA248XUXR+rOGqfK9O9B1rEE9n6l4Rsr9A?=
 =?us-ascii?Q?/Fqm/XLnarUGPKa1GyLj5bGPDzzJsezdhJtbnxhxjzjIL2YVHPHDEoApoXRJ?=
 =?us-ascii?Q?d8zV2TKPGP4kuV6xplrpctxJCfEbbkGuaD7htGtcXrmeBVjelXVZTMqtQI73?=
 =?us-ascii?Q?tv6rTMsboZK0EWlvSdyrmLVgKEopomGvprcBuUK8sqp6cNnOiNbYBCSlIpk1?=
 =?us-ascii?Q?LW6guAt1eQMPBSiUBHSER3d3e5xeY/u2yNL+ndKMdrREZ0qL93hAj9E58Pej?=
 =?us-ascii?Q?XdCYnty7vqJwbPV48IiNjw3Tkc/Va9f05fuAkMHTQgioy2sHNwbrDTAtAYaq?=
 =?us-ascii?Q?xE0Wh5ZbFOfA0MHqplHRQ3Hm6S2x6pqIhNiW5nPKAyLCHN9BnQMBbRndrV7y?=
 =?us-ascii?Q?o4Ckqym+gNE+9B+nCgcIczZJbYKovBOWHGKbXwKfN9lKqh8zp0p/UTvTOlNP?=
 =?us-ascii?Q?NbfqKgfsY4RZLee0y5NKOHQKVlI0r0+X+lIKJmBiGHUn89dyiZvZYW4jKHwe?=
 =?us-ascii?Q?mw0rdgBkOb23L9ufqF0r/UIMM+YbdsbqRbLpRdjGqw6YHkEnekSNACOkjarw?=
 =?us-ascii?Q?Bh1SxyxrRp4qN61f9L8y9HY87qMjgXcHeVO/uUYaSpFqzpdssIM6cMGbv/9l?=
 =?us-ascii?Q?zek7U9SHlSjPuadmdy8n0BKfZ9OiHhG9g7vB/pbec63RD9+DPlTK/5g8YM4I?=
 =?us-ascii?Q?sJ3Rcqn1Kquhqd9XExlKqzN7EH883CIPMKxZ8flIuHNg2XH6WLGt0gtrRneF?=
 =?us-ascii?Q?J1BNdfCeuQrxCFxIpqZILlCilCPjNtGAP+vE4h9D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a5dad8-bcf4-4fee-8314-08dde8a417ce
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 15:36:02.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI0BmGbmLkuudQTX1H+I6umJkBDoLV7hq4z6qSUfBX5ZgmYiFOFQwAYO4qs4zeHY62c19TfZmmI0FCmooFWlxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On Fri, Aug 29, 2025 at 09:54:26AM +0000, Hangbin Liu wrote:
> Some high level virtual drivers need to compute features from lower
> devices. But each has their own implementations and may lost some
> feature compute. Let's use one common function to compute features
> for kinds of these devices.
> 
> The new helper uses the current bond implementation as the reference
> one, as the latter already handles all the relevant aspects: netdev
> features, TSO limits and dst retention.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  include/linux/netdevice.h | 19 ++++++++++
>  net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb..42742a47f2c6 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
>  void netdev_update_features(struct net_device *dev);
>  void netdev_change_features(struct net_device *dev);
>  
> +/* netdevice features */
> +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> +					 NETIF_F_GSO_ENCAP_ALL | \
> +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> +
> +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> +					 NETIF_F_GSO_PARTIAL)
> +
> +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_GSO_SOFTWARE)
> +
> +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> +					 NETIF_F_GSO_ESP)
> +
> +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> +void netdev_compute_features_from_lowers(struct net_device *dev);
> +
>  void netif_stacked_transfer_operstate(const struct net_device *rootdev,
>  					struct net_device *dev);
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1d1650d9ecff..fcad2a9f6b65 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
>  }
>  EXPORT_SYMBOL(netdev_increment_features);
>  
> +/**
> + *	netdev_compute_features_from_lowers - compute feature from lowers
> + *	@dev: the upper device
> + *
> + *	Recompute the upper device's feature based on all lower devices.
> + */
> +void netdev_compute_features_from_lowers(struct net_device *dev)
> +{
> +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
                                       ^ double space (in other places as well)

> +#endif
> +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> +	unsigned short max_hard_header_len = ETH_HLEN;

hard_header_len is not really a feature, so does not sound like it
belongs here. I'm pretty sure it's not needed at all.

It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
bonding: Handle large hard_header_len") citing panics with gianfar on
xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
headroom is not enough for fcb") fixed the gianfar driver to stop
assuming that it has enough room to push its custom header. Further,
commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
from 2012 fixed this driver to use needed_headroom instead of
hard_header_len.

The team driver is also adjusting hard_header_len according to the lower
devices, but it most likely copied it from the bond driver. On the other
hand, the bridge driver does not mess with hard_header_len and no
problems were reported there (that I know of).

Might be a good idea to remove this hard_header_len logic from bond and
team and instead set their needed_headroom according to the lower device
with the highest needed_headroom. Paolo added similar logic in bridge
and ovs but the use case is a bit different there.

> +	unsigned int tso_max_size = TSO_MAX_SIZE;
> +	u16 tso_max_segs = TSO_MAX_SEGS;
> +	struct net_device *lower_dev;
> +	struct list_head *iter;
> +
> +	mpls_features = netdev_base_features(mpls_features);
> +	vlan_features = netdev_base_features(vlan_features);
> +	enc_features = netdev_base_features(enc_features);
> +
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		gso_partial_features = netdev_increment_features(gso_partial_features,
> +								 lower_dev->gso_partial_features,
> +								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
> +
> +		vlan_features = netdev_increment_features(vlan_features,
> +							  lower_dev->vlan_features,
> +							  VIRTUAL_DEV_VLAN_FEATURES);
> +
> +#ifdef CONFIG_XFRM_OFFLOAD
> +		xfrm_features = netdev_increment_features(xfrm_features,
> +							  lower_dev->hw_enc_features,
> +							  VIRTUAL_DEV_XFRM_FEATURES);
> +#endif
> +
> +		enc_features = netdev_increment_features(enc_features,
> +							 lower_dev->hw_enc_features,
> +							 VIRTUAL_DEV_ENC_FEATURES);
> +
> +		mpls_features = netdev_increment_features(mpls_features,
> +							  lower_dev->mpls_features,
> +							  VIRTUAL_DEV_MPLS_FEATURES);
> +
> +		dst_release_flag &= lower_dev->priv_flags;
> +		if (lower_dev->hard_header_len > max_hard_header_len)
> +			max_hard_header_len = lower_dev->hard_header_len;
> +
> +		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
> +		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
> +	}
> +
> +	dev->gso_partial_features = gso_partial_features;
> +	dev->hard_header_len = max_hard_header_len;
> +	dev->vlan_features = vlan_features;
> +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> +				    NETIF_F_HW_VLAN_CTAG_TX |
> +				    NETIF_F_HW_VLAN_STAG_TX;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	dev->hw_enc_features |= xfrm_features;
> +#endif
> +	dev->mpls_features = mpls_features;
> +	netif_set_tso_max_segs(dev, tso_max_segs);
> +	netif_set_tso_max_size(dev, tso_max_size);
> +
> +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> +	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
> +	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> +		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> +
> +	netdev_change_features(dev);
> +}
> +EXPORT_SYMBOL(netdev_compute_features_from_lowers);
> +
>  static struct hlist_head * __net_init netdev_create_hash(void)
>  {
>  	int i;
> -- 
> 2.50.1
> 

