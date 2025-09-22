Return-Path: <linux-kselftest+bounces-42085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095FB9332F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 22:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A8C7A85FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8072ECEA7;
	Mon, 22 Sep 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LdX6BUmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA02D77EF;
	Mon, 22 Sep 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572241; cv=fail; b=fzb1HlCdkC51Iw/8ViR8+csbXw+FB1bgJ64ytm7dHWA1YcJyYJJhoFPO1/Gq/oyO8X+V6MQxsc3sNkpy4KatwHgQIifYmf13MThMji7mJmMnJK0WsB/gkiyjrMHoA6CrkNXsQQpKI2Ehp62IAt4q/RhrWiso2vBhaupRf53ZHoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572241; c=relaxed/simple;
	bh=//A4PMCU54DzceSWzP7ZSH0zY9WKiEqLQMt1yMPcucQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cupRLnKxngC6FYmgv532A6UTLSTRvzlMGHR7UXOYJZBJclvMBkjci3wcn3Cceq7tc7Gt2nQC5+enzsb0dmweeV2MEc6Vb9CqNBkM9OtDZRSWC7ZfkdmTxrW44n248+PoDmCEY//YWI+G7YSNhfnnPbKdUp4hFVNWoKHDzARLYko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LdX6BUmz; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9ROKMz7xy7wsieWkF9jzjljtIvEXDVSmH0xxsWTkJAQ2Zbbk4XzlDN+ZBOMqXSV3NS1+II6LtiBZpnvbFGhApQ3vMo5o57jf4YcLaT0JxgLpUhunh6xf+Sq32UaIrAYaFWDq2/FGL0/oD6cZAmoG2niJpdXEWhfYIDqN6C5jIAEm8u/Jst6FX4UP16XvATwnuoR5oBgCKvmf3hFf060RwxZq5az2jLskG+2M1zAr4Q2HYZcZrMw0sabYhe77k5NgJaLWgXTIjKoxYlHTjf0XTmk2WFJRfiRJ+NWKc0L05ulJO1Jfj75KFljmV8BaR/NhbAvarYPUStRVPmg8gqJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxFhaZKNdSeLKHJnw31YJFOiHJQymr8/IG4acMoH2eM=;
 b=HdzBMEpjUSJj2QfoXS+y4HIqwU7wjKvTwemEg/unRYLsi1XNVB1QMq9smYh0y3Nn+2y4Imw3F2Si92yT8lTmIzZ6sjh6FJN7FexT3o/p081CKscc8a+bMk7ajqvDi0GRZj6mpv/xaUlIs/2rCke0GF6LJafLxOP840+aRSJdAVglcjfyUx1w7naGS9ky0PYXiotRiyjaEHNkv5EQaL3DcJg2OTJjAHE+y+POrhvSEwQy7GfP7iKVXksMplC5Yo6jcYKytKpr72n1G+c7JxmxcQmWrp3p2oYnHJ7gpJkRKrMw8BhaszVLYsc44dX3bOvYlBb1vfOcvOoTjfcnzOEVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxFhaZKNdSeLKHJnw31YJFOiHJQymr8/IG4acMoH2eM=;
 b=LdX6BUmzUd4BQPK+dPfrpM4pp7GpEJph88qDaFIxfUXGab7Bsa7trAz4C/SdYSxHTJBFYMyLIVIYnHNBP57ndU+IR8sKfzJfxCiKNl+1CzQ0bRlRZbuaaazxrMvcJ8Li8UK6uNUSb5IsHUldzKq0blo9giA58MdTrECYRfQAGjUEKjQm5/gn0Iyd5oVYh1IwPGYfgUTbBA9Wzt0CIrIpchbzcmujcjzkasErdp/JCEwg9aJ8sJ3H6unzIiGuuPSN1NLc2YUe61KwsfK7w3Y44xqs0X5SFsBZm9rQd/Gw8M/OkedKXJywnHCDJI07LNw2Xhtt42RDZ/3PvK095yFbZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 20:17:13 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 20:17:13 +0000
Date: Mon, 22 Sep 2025 17:17:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250922201709.GE1391379@nvidia.com>
References: <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <20250922151040.GA2546062@nvidia.com>
 <DCZG9N3QIRNP.1HUDPVL61FZVR@kernel.org>
 <20250922174010.GC1391379@nvidia.com>
 <2025092228-pope-barge-0aa3@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025092228-pope-barge-0aa3@gregkh>
X-ClientProxiedBy: BLAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:36e::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: e33dfbbc-9d65-4511-ad09-08ddfa15041d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CEeat3TJe9FXPxkGtQKxFR1UEahc18sMKPCEqtFKr/OZzM2FPC62j7uEb2AL?=
 =?us-ascii?Q?HCx6vVrEeP3OS70H+IUSiFb7Mw08iPG1LjdeAcs4FJ3lJRNgMliV/OBMNpaJ?=
 =?us-ascii?Q?yBlFSk64IAqyrh2Z2sj9nRiKvfCv/c6sCmqxYTII765Fy9YCLYcrWuHTFNjr?=
 =?us-ascii?Q?oxAJcZR6GC+4CETHr+22EJYL2j4c+EQIeCSAmn+brE8kjCP7z9fdV5aTazMW?=
 =?us-ascii?Q?gh4/k3TIz3bi5sRqwe5kOp1QKYrhnhW9J3548ZuH28M2SJhScu8Hwm4ao8xy?=
 =?us-ascii?Q?p1zK92a6DoUxVa6JMtYtIp4lRxceKrcmnazy7QVISQcC7eP1VZLxEp+kOQ3Q?=
 =?us-ascii?Q?cUnKs7vSlOYV6QidERgSqzpX16cl8V+zfBpWC5+xgMmLcJ6yPlUOVSmBUiyO?=
 =?us-ascii?Q?c9Zf1H/WCPC5jVYYfsI8/qX7kDVwdDZnaqcvCho5206POr8s3HhvjTFSbAHy?=
 =?us-ascii?Q?cTA+jRkijOGO1EqHdS4SgGvV8s/bkjx3U22fpV1QWzB+b0wPK/vsokoJXoRW?=
 =?us-ascii?Q?oy/PHeRxVolF3uvNsGIdvhJt92mm9tbLTbHpRnyu1IoBWRUAj3hlJHNPCqF5?=
 =?us-ascii?Q?i4hHOF3jebq0XW+WtE/JP0MY5wNpgNWZmcSrC4D9abdv/HjqkdfVsfXgh3jx?=
 =?us-ascii?Q?JhGABKZzbUb1no4uiEApTnWxAY7D7eQSqNvJWfNgvFV5pa5pq/jCmfDHbYkp?=
 =?us-ascii?Q?2FnLpD3nuxzK2JMiTWgt2Q/5+PDY6hTn1mYvM4vH4Ie6r3/8pAh5cRK9CRSQ?=
 =?us-ascii?Q?vsMlrYvrx3lu7VzBHc3gce9qBqkBbHYusx5LFQIijAD+Kk07H1uq/n/HY1NF?=
 =?us-ascii?Q?vahwTS/L4DRQBOL9NwcEOxaixumpUG1IkE6YKxaycLoMtzW2WXkJcRkE3K0s?=
 =?us-ascii?Q?v/BUmhiFJm8194W2mYqcf4SdnXQpRIql7jq5HrOkqLECTnNQoB7Szki27Zln?=
 =?us-ascii?Q?5sHN5jKvovSHvBwBT2Sw/AaDLP0Fm3dLtJiL8AKLh8obdi2ZGRUyQQCQu2mx?=
 =?us-ascii?Q?xsGUJqAqxwPXUH20ppQ57MFqwz6CgjZ+YjGPr3Ra8hK7js0UQQqaXQzKx1h1?=
 =?us-ascii?Q?51X/jg3jpcTd1rGcT49GO34T+KDkka/+ANIyZI+QQSHMFGRrfmOG/ocyzBoQ?=
 =?us-ascii?Q?SOJopGHDUhY2k/YYXgHZlhBbnHVZq5EusUFeltMVXawAxW4LAonZe0P0qhnF?=
 =?us-ascii?Q?4IJ4B9gRJxiMVDlTuQY9f/jIFazUt3ru6ftNOS+XyrxHpa205A/fWVLYaExm?=
 =?us-ascii?Q?goQNS5SjRkv5rPEImqZ2E/DMaAPYpd8t4uutrvMebNxF9gpnvDqTdrwR5Ymi?=
 =?us-ascii?Q?glv5uDbYGJNOpUCtcIdtXH6Xr+tdHPS1CgbLyaDcyVZz88mFBrE2eIZfwxgL?=
 =?us-ascii?Q?GUBRNnAepJhK5QitLDxWsBBe3vdWeyfymTLsQFQXPuc/0I8MTMYE48GU8gqJ?=
 =?us-ascii?Q?8Y/Z848kL30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GDIKT1ODsW64VG3c+s3VkZUIeOwa8WlbCK+Ql50DICiGtkDlGXVpbodsIse?=
 =?us-ascii?Q?aMeTmflWwzH0mVPK0a5gxggrQI/AhjQ+tnk0jlxxqyULpJ48+89Lq9TSQ3In?=
 =?us-ascii?Q?SS0ZeHzqEPYy0XGsgFZn0/r/21qTbMKza19SeA+kYt8ne840856v8LsjsL8G?=
 =?us-ascii?Q?z3MsfRGbQ8fNQ+pApmUfr74nZ9AksUN99pK1Oxz2pNFKW1l7uosuSkrh8Yc6?=
 =?us-ascii?Q?lPLUyFYFlWAQwabKN6CQ0GWGQh9WfaPawncrO1+RfJ+FRqs7VeaAGSJ7ZK2t?=
 =?us-ascii?Q?DzOVnpU7h2rDrSg4LQ79GAYsFrr8D81sTYIGY23DNLoSZ3x7ikgBGf+YnXGi?=
 =?us-ascii?Q?HtwVXxoCwKxAzIUlraqK9gq9bqqVN305xVNS/rAYSe5SHu3Q94qpCaB5ozej?=
 =?us-ascii?Q?oi7sVFeHk3UYY1X3WdEEkgBF+kNn3Dro6EqipTPpdmp9Zk+EKBFBVf/Mp3Bj?=
 =?us-ascii?Q?m2ipFhsyjYLZG8jVra0rCXufclCF5BhGX+cHeSW6dIfIYos19EzQ71DtVx9r?=
 =?us-ascii?Q?8O34nIEsUxJlFdo0wqEs8N4RZVLDM8dIAAfI9lYqBdiuafTnpq5y2KoS7Y0K?=
 =?us-ascii?Q?Btdo/6JkotcGKcMITxJt+xVNl3pOAESWpxnzwHIXsYcOYkbKh9k2KbbwbvTA?=
 =?us-ascii?Q?tM21PD6owPteV/hKQ1xa5YLuNZI+afODvUjjsJ/i1x9jLR5heIQHngzn/ALl?=
 =?us-ascii?Q?gxuFsQnjepCKz1iBC8yIbGYsDQLioj1oaghswY+copSQdctf/uXinGpQZs/Z?=
 =?us-ascii?Q?IB6Axym7PxLffUQICQgDVlNrfKxlC/AiiVuIpdG09PZdmBUANGnjwboqgGBg?=
 =?us-ascii?Q?sorNYb4DwGfBrj5L2vlXOb/qyAboyi8NzVC1yOi7Se8S2YU79lQOrQ11kydy?=
 =?us-ascii?Q?IMsN5/zxd9hU4HtrjBbH627ey4Lwa/TgEhl1HuF/oZqUKvE31ibVoeHx9ze7?=
 =?us-ascii?Q?eWg8oPaUCDy1rLe7wYJuoN9rtUEPWQW0KpxxPDS3uKfj5SYSBkZAbES0Veg4?=
 =?us-ascii?Q?nq/BOwav+RUOmyF7JmhknsNOPtNKA0MlTV0ueND8Gd5NlVaY0KR2DEH6U19q?=
 =?us-ascii?Q?MJhpYbfk8NtbfN3TcsR4GrviSbDyy59wtnGEdfsal9LjmC5vzDLmP1LdvbsF?=
 =?us-ascii?Q?nQkW2p2mjYAjvoy48mgNBu4K5+SddeSMi6ksNRD6mf2DEVbinIxybdKi36+f?=
 =?us-ascii?Q?uzp/umyKImXQDBzqLf6LKEn/dZnQX/V51JtzwlLilwz8zaSpIdTtk59GyF/z?=
 =?us-ascii?Q?07oUdYPNzSJ003auXSQW9msSaA0Hyupr9huTqqVoe0Ok7pGLiQovbXOvN58R?=
 =?us-ascii?Q?sT5sIWI3mSRvsSrwHNrZ9EenTIKhg/LzJ1dEXZA/HlzLa+3KgAVVAuMkhhuQ?=
 =?us-ascii?Q?+YilI78mjCvRvb3jlbxhH7lsqeR79pQwNFtSKaAm3WU/mLOpt5T4wrgWDMy4?=
 =?us-ascii?Q?R1BPwYT6PMIqQWKPDsANXuL8Gj89BDI5osWMGp7hQgqX6R5m9JvtJA5F6kVu?=
 =?us-ascii?Q?OAaznAcLmJTqLH+zJf1lTp49g/a+9P1skhvo4JCVCvfp2tKFRtU1ClcRLD//?=
 =?us-ascii?Q?2+yQ4fL+/kLJN1GEtZxcPUOTKQYb/Cg+4gFIYLMc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33dfbbc-9d65-4511-ad09-08ddfa15041d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 20:17:12.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLrjI9Ln7u0bNiBrHJ/wm5iXwIjlRfLTN7nUzDMAIw6RlA73tDLpDb6t6op3Iqtw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

On Mon, Sep 22, 2025 at 08:42:23PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 22, 2025 at 02:40:10PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 22, 2025 at 05:55:43PM +0200, Danilo Krummrich wrote:
> > > I fully agree with that, in C there is indeed no value of a revocable type when
> > > subsystems can guarantee "sane unregistration semantics".
> > 
> > Indeed, I agree with your message. If I look at the ec_cros presented
> > here, there is no reason for any revocable. In fact it already seems
> > like an abuse of the idea.
> > 
> > The cros_ec.c spawns a MFD with a platform_device of "cros-ec-chardev"
> > that is alreay properly lifetime controlled - the platform is already
> > removed during the remove of the cros_ec.c.
> > 
> > So, there is no need for a revocable that spans two drivers like this!
> 
> It's a very common pattern, you have a struct device, and a userspace
> access, and need to "split" them apart, as you say below.  This logic
> here handles that pattern.

This is two struct devices, two device drivers and a fops.  There is
no reason to trigger revoke from the parent driver to a child driver,
that's just mis-layering and obfuscation.

It already subtly relies on the parent not triggering revoke until the
child is removed because it added this to the cros-ec-chardev driver:

@@ -166,7 +183,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
	struct cros_ec_dev *ec_dev = dev_get_drvdata(mdev->parent);

 	if (!priv)
 		return -ENOMEM;
 
-	priv->ec_dev = ec_dev;
+	priv->ec_dev_rev = revocable_alloc(ec_dev->revocable_provider);

It would UAF if the revoke is triggered by the parent driver at the
wrong time.

So why is the parent involved at all? Why does it have to violate
modularity?

> See the many talks about this in the past at Plumbers and other
> conferences, this isn't a new thing, and it isn't quite as simple as I
> think you are making it out to be to solve.

There are more complex situations, but this isn't one of them. All
this needs is to fence the file operations of a single cdev. I've
solved it enough times now to know exactly how simple this really is..

 > struct chardev_data {
> > 	struct device dev;
> > 	struct cdev cdev;
> 
> Woah, no, that is totally wrong.

Sigh. I'm sure we've had this exchange before. Please
re-read the documentation for cdev_device_add():

 * This function should be used whenever the struct cdev and the
 * struct device are members of the same structure whose lifetime is
 * managed by the struct device.    ^^^^^^^^^^^^

We created this helper specifically to clean up the refcount bugs
around cdev usage. It supports the above pattern which is the natural
and easy way to use cdev.

> And really, let's not abuse cdev anymore than it currently is please.
> There's a reason that miscdevice returns just a pointer.  Right now cdev
> can be used in 3-4 different ways, let's not come up with another way to
> abuse that api :)

It is true there are many abuses, but converting cdev users to use
cdev_device_add() is the right and best option IMHO.

miscdev is not a good option in cases like this because you don't get
a nice natural kref around the memory, among other limitations.

> There is no performance issue here, but there is lifetime rule logic
> here that I really really do not want to have to "open code" for every
> user.  revokable gives this to us in a simple way that we can "know" is
> being used correctly.

I strongly prefer Laurent's direction to add a helper file_operations
that automatically wraps all ops in a lock.

I think all this series does is create a weirdly named lock that
drivers still have to open code.

The fact the very first proposed user is already abusing it to
needlessly violate driver modularity is really depressing. Let's not
create another devm :\

Jason

