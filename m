Return-Path: <linux-kselftest+bounces-3108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696782F780
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF82284296
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5C81ABD;
	Tue, 16 Jan 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lccq74T+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C81AAF;
	Tue, 16 Jan 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434472; cv=fail; b=j6C4mjbA+meivaJhb1B77/wT64zwZ4yp1PxirWEpVBTJYmFh+qK9estR0QmuqJHR+hBiJNw8XgGcE8k550mVsEg9gT0AZP5V4gWVVMaWIYn9FI8Ra4ChZsrRMn9m70m/kcZfzuj6awZx2LcxWg2agUBj0g1772pT0HvZf92fiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434472; c=relaxed/simple;
	bh=GmzW/CWcRBZkEBxJ/zowBSdBGIamRcb25RZWz8S3j/g=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=jLVUjRzRaXOc9UxpdXha8mku2XQqdMX4xX3i1vVgZSZEJ1rIIZTJaxczzlZUmhH5nms9fLWNYqnsB1OPdR4HLRDgoYb+J7VNrxJMdx2QpaocCm6P2GqyqHWbAkQ1VXD9j1Yi1FFmjLAnMfXj1x6b7AHrL0ahQ/q7pbWkXiD0YuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lccq74T+; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXcRIhCrLsSASuVm+/L+q5s5YNaD/fZ73iYfrS1VblMlp971gP4+WDIGraoemqM1jn4cnrlBDWrCBfvUG2jL7pGoFe2ZTSLJkdgQsZ/vv6/e/ApXhjZ+B3TrHbCwYdD9GvHRyCAECxVsUvb80e6cfnaO96BbHlNi6aohQPcgCuFwLckupHZyZ0PrWpFUZwGF/dDXEnODdQyhHW+z/tA2iC1LrnxrQkj0wQd2ckJDjZ3VGcaxB86HRmY7+gI+DnMDaRgwRIOKBtjwsHdnCzLWUXJNwcIv9wQh9JfidNCwj4Y7VOJDiuu13A2xwgHNPH1ezH69P/IsBm/VuFjcIwrcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCJYNm+oy5n8QIYf9+AMaOWPjuiuZMT0iuD7BmIfzkQ=;
 b=IobgDfjl0RHyLTyjO46Ikn/UU381qWVgukSKFmpa9c+lq5qYkvDSl20ekfrl79GUNUa7nDa/agJiSPzWfCN3IcfkWD7Vet7bMC2x4YCjQy879/Gm8pLN7pcZPGgestraORks0okVhMpmNvzSCci6Ye7wEzpnYY8h9q8iJa7lqzWmD3yO+l+ysA7618DiwWneG3VtRZmAk1HfDQJ9apSk9YuBhoM7OuxND2bikOGyvVDa3hCFOzut/MNaAqujGCSBcNHElzQKoh4d9xLDJ+3KHDXsmo7IcFB3t+lIgFTuR3brWC1csGlU7c6mt8YVJbc1swSVc9y+ubY9zOJmgrsyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCJYNm+oy5n8QIYf9+AMaOWPjuiuZMT0iuD7BmIfzkQ=;
 b=Lccq74T+RZ4EqZPSxomgfYqgjhDwqJc26GfzxdN/tDnlMk3FrwORuZ0zwgXHHo9hH+qw/IG4X8s7EKMmG5Rg2qaZB+dCr8FdpKN4xTUFb1H6Yv+YBa9HNUw955wWt9ePKbYbYqUHv69K9m49g/4uLgf+L+6bPFSsmJr71CXOnuL6Lp6IxvFIrs65y3EY+BExmJpGoWP093l8VpaVBqmMiKBwLcbuOvKmKiDYtCIw0ErdH2ydJfWe0NMzArDW49vRgJ0aKqkoizsibjg+mJv6dFxEgOAZtrwo9UmzMjCwf/klZA/pFBZDQb8KH8krWy1POPZNgl8dmuK/JTdZ6w58kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 16 Jan
 2024 19:47:48 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 19:47:48 +0000
Date: Tue, 16 Jan 2024 14:47:46 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <ZabdYhBRHiNt-jGy@d3>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
 <20240116104402.1203850a@kernel.org>
 <78106.1705431810@vermin>
 <20240116112012.026e44d9@kernel.org>
 <ZabXT2ZepMuinE50@d3>
 <20240116112926.541e0651@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116112926.541e0651@kernel.org>
X-ClientProxiedBy: YQBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::41)
 To MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da01fbe-59c0-46ae-63ac-08dc16cc0482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C7R7pAOPq8AWdBYK0XcHEkU3nE5FSYmZHOs1OkLW/tn0Arg4lA6gpqtNDvWpz6a+Wbl6ad54mU7vAvhKcPWq5UMkBdcrNkPepMRzheiiyF1hG68c17B154v05HKOSnsZfT31s4SCWbYgL67NPB99SFJF06OtZpi1+LMg2Wd4lxzltbke9UxQR2J0lBNLkdB7ZxJbr2RE0DPv5s1a9mLDnDS9ZTZQdzWmF2QYdIWpjCktNn80HDc6wwo4RmSn5PCraGD6xoK+DWdSq6eJbMVIFa4MnDu6qnUFtPqShN+Lb0CjWExFLVb8IDr2SpJl5ArF1gA115OltQQGd72l7AOyXfYomN1M8wcMheKbtmDCPe0ZlyBw8meGx4CybJjzzdaTtFB7rHO5XS6m0pXiBdjK2/IuhGpj42NKYy1eedCoNCsNOi7OJ3Tr9YhzuelN0UHhLGX/mQHYRJc19kyU7UwvQaaoJPYCYzlPNXMY83LdaVDdnU5826+aT1A1qcvpsE6yKdHxxee7oWYRI58/qTd/BRreokmBX//9SmZrSz0RJ+5u1u92GMbOMC0EvnRX6L/I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(26005)(9686003)(38100700002)(4744005)(5660300002)(478600001)(6512007)(53546011)(2906002)(7416002)(41300700001)(8936002)(8676002)(316002)(86362001)(33716001)(66476007)(54906003)(6486002)(66556008)(4326008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIbZYsZYGK89wESv7N3y48hQS//c+JQAnevC/c46jg/Rz2zkbXoKYwHK0B2u?=
 =?us-ascii?Q?FCPo6/MGqGEM2JW8U0YO8zoajXdk1UFt+wDfnwvFekyTbo3e3hOh5rO+Ekwd?=
 =?us-ascii?Q?xzc75RDzfJXCLbmOmuRHO1zcFwn+AhJYIhl0GBRcbv3LQVM5dG1G+n31pInr?=
 =?us-ascii?Q?WlQvBwEWIgKKaq31CBu0MfnADR+JXzmR1+wzAUzVAgvvzrEFLerP84C44xQT?=
 =?us-ascii?Q?z2VCjJvvrlaITzPQqFtU8Zn6F6iiHJz7TwaM5FXOp1SRNIbspycCOgbyc/AS?=
 =?us-ascii?Q?6kmTpGgRPDFAiFwUaEm2x/VFKLnOdKiNS/rVRr5UnIAiIGAK+OuFabiiprwr?=
 =?us-ascii?Q?pEbXlyqO8Owrqd2wGcypMxCwRCKmtLlAlaBw2ocnELDJ7d1Sa2bB1YmbxMTp?=
 =?us-ascii?Q?/btuUEBR3kfdFIFVNhKUDnNrQfw0ydvertfxjaP+U9AfGNM8Y8oXeku/Ve++?=
 =?us-ascii?Q?4ZfnPWIyNa3NN3cgrcH03S3gEBkTvUL2bSowhtzyWe2GvAFSF8yN7F2BLECM?=
 =?us-ascii?Q?qCAp+uUe1l9yuCox8AOeTZaRUH/oqumkWmFCQU/Blm98C6CRfc9Kd0rAUjen?=
 =?us-ascii?Q?5+msgL1spjNrGdBVQ9SyaNSj10+PSqVbOC1/dg1wFpmlri/AN3l7kVW8ikH2?=
 =?us-ascii?Q?Yt3SCQSxkG4uu0HqTbHm9TQ2mvLKBIOaWhwpNJ6qhMXU/yj6XSFGY6XNUtBo?=
 =?us-ascii?Q?/swBehyihfB3/CWuWj27nfEdZ+OkTUVB2VI1iTvdmCimhW8yz0qNyRzmbCjE?=
 =?us-ascii?Q?68qE6hlKtKFxdkFfNUYc4VQ1BbWAWGOd7ttDGvY+h4Y2LcPW4vVCijUjsA6f?=
 =?us-ascii?Q?DVhjcqBtTRlh5K0sgFQxqEN2nOLiFcNQPsNKTzTs0qGo0t7hWq/r151Zn/OG?=
 =?us-ascii?Q?eRRe7IcivVEMNLyiTGKTuOa9ttORa7qAVCl8FtvwR/DjVOM6T7xJwH3aBeek?=
 =?us-ascii?Q?3aHAjO4UPTkyToJDjx/qmRVlFJu1A5WpnjVPXQZIByymMycbqgpgU5R3Et3q?=
 =?us-ascii?Q?+TEvej6OR6ll9Q+uHv2FHEgUvDCvrnwjnw4OXzQ4BKJdy6jmElp4a2N1tT+4?=
 =?us-ascii?Q?00+Mlorhyd0tNM1qd9FdRZ7kfHjwiVzKz97jM3tKFtkLy+XZG3zZjstlZMik?=
 =?us-ascii?Q?5Du8gf+hnwNwcie8j/+ZJc9Pm0moX0dVlfBQ0LT6fV1tq2/oPWxCow63xtba?=
 =?us-ascii?Q?72E7Wwp/n9iUoJF22nS8ZnKnUgCTOyWSMLBpDD420AhRvb1s4tE5cVkcX9Py?=
 =?us-ascii?Q?uBr6RN97XE3nJ9VCHaO9M+m0N13AzD9CDepK4jWMYWEK62DDCCc2mYRsfPMd?=
 =?us-ascii?Q?5GqWzwHgpe+T7vmlkQ9U7KZ2GnVd8Dw1E5jn3qZ8SfHfIFhv1cbw07OmYK+q?=
 =?us-ascii?Q?DKwuL37zaj8UyKVwJCK9glwR1OepFcoSYmmRfYsdAVF2GsxAwHLuDbV7D+pg?=
 =?us-ascii?Q?k1Gn1MrGGE5/MLCg6aitoKJLz14QyreQHzh54ODhmEXkKJgZZXRMxdyl12oH?=
 =?us-ascii?Q?bkvuWYzAvPWbrbipdoNAbOueVs/LxiFhriYeF/sP8yOorEyynIImU9VI2J1M?=
 =?us-ascii?Q?acnaJ+ZzycYovQUVUV4U5dK8diVzk9DDUh/wjkwc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da01fbe-59c0-46ae-63ac-08dc16cc0482
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:47:48.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooZIkV58DosBa5a5s0mQMK1CvKdr6dqlWZmb9hr/KejWVZovPJ7i3GhiADuV/TW6m18U0Y1c1HqhzSnDhd2F7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

On 2024-01-16 11:29 -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 14:21:51 -0500 Benjamin Poirier wrote:
> > real    13m35.065s
> > user    0m1.657s
> > sys     0m27.918s
> > 
> > The test is not cpu bound; as Jay pointed out, it spends most of its
> > time sleeping.
> 
> Ugh, so it does multiple iterations of 118 sec?

There are other test functions in the script which include a lot of
sleeping.

> Could you send a patch to bump the timeout to 900 or 1200 in this case?

Sure but I'd like to give a chance for Hangbin to reply first. Would the
test be just as good if it was shortened by removing some cases or
reducing the time intervals? Or is increasing the timeout the best
approach?

