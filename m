Return-Path: <linux-kselftest+bounces-3095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752782F53C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CD61F2495B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE91D52B;
	Tue, 16 Jan 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bHd1K5JP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7791D529;
	Tue, 16 Jan 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432920; cv=fail; b=kAxmPLAbdZkFKL49lrOqIJVuMAMUWk6fZUD7WVkTauxdukEP/NbY12Kf53jhI7FeZMNTIX9np7rztE4UdlLxYuM+TGtC4fFUIWnAGfdjL7p/9dN7GZCEeFfuU8xirftLQpeKYuBX2SSOyRmvkWx3PSZ4n/50C8mnKsiqYynHTRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432920; c=relaxed/simple;
	bh=KAZwrBQ7O/eUxrx+cnJk8WFKEDmLRkgAjR5SCqvLt/4=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=FZcNsWAytYvWW1J3c1MzxtGrNxQvk2yjO7LN5ePKY8XGr4KYJMycTO+d9ENUdR6Hzf9zshhdiiVmTrR+UWYPZEzQm+T6W9pJ5d8HXDY8OfL7KhlQIQflw0r+sMjSZcJ5aogQrVqHix0QJpZU7D9N4Ti8nvA6SoL/qD6U+YdlkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bHd1K5JP; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnC0ABmEBho/WGzBsLGT/T1NAvJkhXAtNyrePEYKidMoRmMQn+QPJ+8Ir6tEJ4zsW6DKttJTYPuHsP1xkFnhXpc2ta2UNI6U77IGZht2Ew/Sv9UzhhCI49qXIEZmbivOUB5PWRfBll/wn5QVF09UaOHpmX2IHj96pbHdW3jmplMqIqVyT+3AHVDFv7h/QVDYkmCovpjG6nkBuvO6WCbqaz/hnLw7XUiebMgFXIxFmErBw7GQfUtLMdgSfd72xNTbtbI8IPRG7K7wY2vSnBCtvm7culqqrQzSsO09MikZjiY2nxQpDAWUy1EvYFTv+IfUuyzRRkjz2jCcjw3oY6fUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2om2sW3HlO8+1WI1jEu8Dob1Cj4wxcpFUII6FcvsRs=;
 b=jjwQCHxgHzggEutjb1Q6i9Y6qc2GSX3nP5t72vaFZoLU9EH0dHHCfs3czdEctMT0z/k0ldjanm6OJ4wdrnDauD+XQ8OhqJPxntlfvRmjvmLQyjA7H1xvwF7gQ3oMFaNKU2ws7xX85qyVVKuMNFyB0dZTfYDRYGnOGzbxg/cDTCZ+C0trWNyiOtpcTcCY0iNZPHsqCDDX0WgARX1Nny18ylCdkroAlneM1QWt+sQt2npgoDXE34PoQkn/Z+xWOskwGh0FTbaZzV9OELI4/RlwVH4br+ImNsfMziC8by8jOTQ1uCfy9gRjP6txreYYNWr9jkIDcXjFb9+INlAbSE8xiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2om2sW3HlO8+1WI1jEu8Dob1Cj4wxcpFUII6FcvsRs=;
 b=bHd1K5JPnAtiMEblxwsTb1WXk7GYmJsAzmMnzbO4gBhyYrI3v/eyaaW88rqJBiq+cFV2KFwgAgNUwJgZBovrZ10gC2ucKgRuwsVLghurWU3g4f4FOFTTS4QhJrfCtx4f+xYIDOGKSsSEhY/5NsDt34EDtNgWzpYo6z2KDdZe+6rvDJELprqvJF/UFtDd98cofTZwT9hcwrl6fDxo3RZCQRBrdkO0fid/kWXGVwiJiVhC0lGEIhO53/QA7Cbdjxogue3dhdSHjZK9XnbjFz3vFw6OMUZ1koiJvvFekDM4A/Hsv2k04tovoloy7fxWUJmeXC0Foq1V2olFZxkaViC5xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 19:21:53 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 19:21:53 +0000
Date: Tue, 16 Jan 2024 14:21:51 -0500
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
Message-ID: <ZabXT2ZepMuinE50@d3>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
 <20240116104402.1203850a@kernel.org>
 <78106.1705431810@vermin>
 <20240116112012.026e44d9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116112012.026e44d9@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0237.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::32) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: e57f9579-f3ac-4943-dcd6-08dc16c8655a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yrQM05Mv30s3guqVf2a5tJLRF7dgyM0aOWe9+8BGZ57/hJTWyeYilKey1hAB+bgjDD5bZgZjBdqXTtCON98TNnMlgEgOAgsGsxMRPbTl/kUsRW96DLYf/9k6FCun59lCAUT9MwBhi+eaXEAUZ0va/C8SOS8Z9EVr/0q2VwSQgUSXZ7toyhP3fG/fxooBageay8p00w/+yTGYSSE0fIvSQ09KDpyRGuLW7U6WWf4iWv7caimZ8ecxA8lPONuJMMZyxaAKdK8mtvXDaHMimSHOPPwyVoii8WeakoeWfPShag0pxslQLWQ+kaeZirblKJWAILvJ5N47VQ7ipgBE7O57dyp4xjqJrIL+qmbnUm0Mv8TiVTiwN23Qn34C3qhbmkC2a17YKWZT1Llx3Zh1okKkaQWQzlfjxuiGELmNF/Iz7+8B7aE2JHBxFCbqyeTQe7DqUBYNorNsJoFNNngBU6spQ2PRIZTZrUWhDQFzbfO3Ueg1bA8sAXFWNTGJ/hbsaINWQDRpr/6KEgrDwaSyQO0Z5qI4+ZRdSDMNgXGZm3m9oXa+v+H2gX5bGEwX1nnddywA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(33716001)(6512007)(86362001)(41300700001)(83380400001)(53546011)(26005)(7416002)(2906002)(9686003)(6506007)(66556008)(478600001)(6486002)(8936002)(66946007)(6916009)(54906003)(316002)(66476007)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wIQN3KcDV07PPKeiAqxna0Lumb9jyjmJhzMKNOjpdQ7VTPagIqq3u4174HXC?=
 =?us-ascii?Q?nqDWRS/Y8eaYr+wPd8r1Ad0xTjPwIYZB6ESCu1UH9gEW6A6HVF1kkvenhObW?=
 =?us-ascii?Q?xK14RpI5Gp1OqUCEISCUrSxA8rmobZmVKsZzL0ds3MsoHG/CeFVnyxAvSIMp?=
 =?us-ascii?Q?k9XvsXDf++B1KuGsZ1S+Odtr+CxJI95jPnV+2ipEglTOi2KYUGFr3KMPTmOl?=
 =?us-ascii?Q?oIDoT3NysZvCho4V8qn8rfRvIioPQEVbxTjV+GIdvMPLVwSz/deki+mKVBlB?=
 =?us-ascii?Q?liRzPc02/yYWGOT9TeTkUl9mIvyYqyJhJnJtlEbf7Plpe7zPw1ypJLCVaGX0?=
 =?us-ascii?Q?tRprVDw6I5VKU6iepgjihO1YEzcFFEeu7wYeWJyfUloVcITlE/IBL80NyIwK?=
 =?us-ascii?Q?dDFxyv2UGMW3O1Tn7orGUkxWd3mOYFRxJ2PoRnNs6VNEvh9EoBe9qLjY+ldo?=
 =?us-ascii?Q?jNi+dqy6ryDP0Ov4QCnSrDzVdP/dSQvTANtg/+C6wsERApTsOVJElorE/lWq?=
 =?us-ascii?Q?QirbfagExqLZJ4MBrMOJYPZs9KSmi0rTQ4bmGbFcS6u0juCDpFCU1Cr00CgJ?=
 =?us-ascii?Q?d9y2ZQLNygbiHu6QmE+WY7vBjpFcjQ8l1ms5GTDNI3u2f11OreDXxtbWhmAB?=
 =?us-ascii?Q?rD/m8Y7O4uSuA5QGsEdgzUFzDq4TTcIA315nlQSW6ov5rtivS9IX2Byo6mzc?=
 =?us-ascii?Q?m31wQXF8ytO7K36LrAjN6RXMSwNs+PSYBCDz2IZc0WPYNIn2yin0MMt39Csq?=
 =?us-ascii?Q?8aDM+/fy8RUhtqgXA9WHDuUsdeJsubXgfx7NrmT2Eakb24PLV+udKMcuH/fq?=
 =?us-ascii?Q?3Y6M0uP5PMUpaqjoEBdROYHX01Y/uGgEywl118xn819UjHLuZKwFYjLqXEL3?=
 =?us-ascii?Q?ChT1EQ6eCCwY+y6OHtYGmjVY6wzJDVPhIXiME2v3idCQ0TGxCCjZtvtJfzpJ?=
 =?us-ascii?Q?t/mW7EchcaBS34Ol+3UfmtM1gXwhM/T02nu6gPNKTrvGrYjS2IcpCZSipp9W?=
 =?us-ascii?Q?SCx/Psq1Qaez6r119NozSZ4b4D9lPZKrVx38sJK2Y99u7jl5DQ4pTRMJ3Uud?=
 =?us-ascii?Q?Pin0sWTKcsl3iH2eg/31A2JiMJ2MWcpmfKi+lw8uwvoWzBSVL+rpwQdzsuyK?=
 =?us-ascii?Q?4c+EwucAEz5n5utC+rnUR98Sy5fuSkFQAOc6qz7GTRfhwqvyeGUpze+RQ5VB?=
 =?us-ascii?Q?7g6xX1hBGovXg5UxHXxy5ccMeNj46/rwTyFW7Lt/H6/01fTQomqqcJMzvDCp?=
 =?us-ascii?Q?5KphBxTqYfBaQA52rv9OcxA35AJtfJjR+XQG+irKtfDTVJriydNYjBOGcnuf?=
 =?us-ascii?Q?E0GACAjkOjwBnSMgZ17RdicJUZdsHs83kwl/8CNYEanH8I0sTOPPUt1cTQM9?=
 =?us-ascii?Q?W5umnqzES3uytamEYMlAVqlO6PgX2vKw9BX16/3C5MKyu59k0cMTasq+ZDH8?=
 =?us-ascii?Q?xh3DDS8hNXAe7Beb3J7X5M2U1bwAkPw6tDiB2lZaV3F61bwY1/pBLwQaXGKj?=
 =?us-ascii?Q?RwWi8rBdAi4d37rXsYF8M8zM7IzWH/ZXvqUY4h+Dfrp3iu2cFfcLzH9WlfEX?=
 =?us-ascii?Q?Rvos/+A97MhxOMPqASBJQV8hog/sf9zy/FDYWeef?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57f9579-f3ac-4943-dcd6-08dc16c8655a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:21:53.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwDAoqdF/EE13VzOG7OImloxUFSMrlwdSwwsEGN43EVzrB2g88VlwECWfatm68XM3kbkI0X9UjgPN4IR9NhB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

On 2024-01-16 11:20 -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 11:03:30 -0800 Jay Vosburgh wrote:
> > 	If I'm reading it right, this will sleep for 12, 22, 32 and 52
> > seconds for the passes through the loop in num_grat_arp(), so that would
> > be 118 seconds just for that.
> 
> Hah, that's really tight if the default timeout is 120.
> Let me send a patch to bump it to 300..

I also ran into that timeout when using `make run_tests` so I executed
the test script directly:

# time ./bond_options.sh
TEST: prio (active-backup miimon primary_reselect 0)                [ OK ]
TEST: prio (active-backup miimon primary_reselect 1)                [ OK ]
TEST: prio (active-backup miimon primary_reselect 2)                [ OK ]
TEST: prio (active-backup arp_ip_target primary_reselect 0)         [ OK ]
TEST: prio (active-backup arp_ip_target primary_reselect 1)         [ OK ]
TEST: prio (active-backup arp_ip_target primary_reselect 2)         [ OK ]
TEST: prio (active-backup ns_ip6_target primary_reselect 0)         [ OK ]
TEST: prio (active-backup ns_ip6_target primary_reselect 1)         [ OK ]
TEST: prio (active-backup ns_ip6_target primary_reselect 2)         [ OK ]
TEST: prio (balance-tlb miimon primary_reselect 0)                  [ OK ]
TEST: prio (balance-tlb miimon primary_reselect 1)                  [ OK ]
TEST: prio (balance-tlb miimon primary_reselect 2)                  [ OK ]
TEST: prio (balance-tlb arp_ip_target primary_reselect 0)           [ OK ]
TEST: prio (balance-tlb arp_ip_target primary_reselect 1)           [ OK ]
TEST: prio (balance-tlb arp_ip_target primary_reselect 2)           [ OK ]
TEST: prio (balance-tlb ns_ip6_target primary_reselect 0)           [ OK ]
TEST: prio (balance-tlb ns_ip6_target primary_reselect 1)           [ OK ]
TEST: prio (balance-tlb ns_ip6_target primary_reselect 2)           [ OK ]
TEST: prio (balance-alb miimon primary_reselect 0)                  [ OK ]
TEST: prio (balance-alb miimon primary_reselect 1)                  [ OK ]
TEST: prio (balance-alb miimon primary_reselect 2)                  [ OK ]
TEST: prio (balance-alb arp_ip_target primary_reselect 0)           [ OK ]
TEST: prio (balance-alb arp_ip_target primary_reselect 1)           [ OK ]
TEST: prio (balance-alb arp_ip_target primary_reselect 2)           [ OK ]
TEST: prio (balance-alb ns_ip6_target primary_reselect 0)           [ OK ]
TEST: prio (balance-alb ns_ip6_target primary_reselect 1)           [ OK ]
TEST: prio (balance-alb ns_ip6_target primary_reselect 2)           [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 0)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 1)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 2)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 3)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 4)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 5)     [ OK ]
TEST: arp_validate (active-backup arp_ip_target arp_validate 6)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 0)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 1)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 2)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 3)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 4)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 5)     [ OK ]
TEST: arp_validate (active-backup ns_ip6_target arp_validate 6)     [ OK ]
TEST: num_grat_arp (active-backup miimon num_grat_arp 10)           [ OK ]
TEST: num_grat_arp (active-backup miimon num_grat_arp 20)           [ OK ]
TEST: num_grat_arp (active-backup miimon num_grat_arp 30)           [ OK ]
TEST: num_grat_arp (active-backup miimon num_grat_arp 50)           [ OK ]

real    13m35.065s
user    0m1.657s
sys     0m27.918s

The test is not cpu bound; as Jay pointed out, it spends most of its
time sleeping.

