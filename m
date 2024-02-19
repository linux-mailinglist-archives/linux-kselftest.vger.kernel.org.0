Return-Path: <linux-kselftest+bounces-4918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15C859A42
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 02:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39F41C20A9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99496652;
	Mon, 19 Feb 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDLSmo2w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E295163;
	Mon, 19 Feb 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304583; cv=fail; b=VWrhnGNWRAhoFy5BQdLJTJQy1Ub9TvCcfT9A6ZEqtMDGFXyDZb3oB+p3w9qkSACcHFNXInjsom8VNnSX0mY27t+/UGwrel3cFN1PaNZdIq4IBqFfGbdlBF/fxzatnXS4S9W9xHO+ObAmS29GKUAfXW8cxD9y8VDEQ0ks4ssRw9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304583; c=relaxed/simple;
	bh=/yWmIkPNVrHeu9cDAyvqnzafmZUGRZj+ZrcVjlEX4ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jk9ZQCHxsf4338udxgL5ikMziEJTT8A7/ZGK6c9GSARFq5uZE4xHt2ZyfAs/FNt36Vt9B25Ntu/2sD+SW8mg3Z1aB1XUfQJpt37ClVv8+deop6+bVVaYlbuHHSFcGQc+C+XQwtqHS49SLGu0SwwJmsY+CU/jVTrfus8WzRDDRMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDLSmo2w; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0OUR9MgwpqWSXyCFsX4ySL2PJEzZLNmYYgfwrbpqBqbngFkSSBZg/r1RLihl3uqp0OXlnnBNYyHDxk7HsOdpfEkwNH1oKds0r8kW+0vzmLBSFDCmb9Wh4+cRA7EPVNj/GJm1OId3mcXFp0nMQlt1A7xWSXbMX3hpQ/lKeQf7wrVzEDONfVvllt5bs7I3Rr+PTrWHulNPx6N8zRGSyN3VuY+UkHc6LDE1Zu5ey0eol4gXUUynRNvuVW3jcx43OwMaPdLSczbwPxnDEHtvgDQ2RQeYlEyZvfo2xzZ2IDS6YvHEXWApkhXzCEo0ItV/MSY70aj0ED3gKHOAIue52VmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yWmIkPNVrHeu9cDAyvqnzafmZUGRZj+ZrcVjlEX4ts=;
 b=N0ZXeYgzgTLR37RCtpvILycXpVXvEVj4DJNHhmgPb/R0sDNYrZ7Tpw0PvMJRxN44jhri8Vp60sbT0vXIfphT+thRaTrzW3L4jPUTLCMKMKWu4ZcdjWLWksqElhilTbVz0pUrk4v+pZLV9bNCFxSYaEJGWCGbWdpUABpEG98uTPSU65kdQE79DtEBFzeMnfl2w3J5d/BiobtfPFOC9VxtFNTHrNhQj1ZcyedjxQDQWG1lUfvKLMM4XJsISm1H1B+/smqRrqXvTvkOV6ebI5yo1pwQIaCK5AsFh/FMjWOxfZbkSXovYlJUdwyJoPoHFGMILZ1rBWMQQetSnKSo7xU14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yWmIkPNVrHeu9cDAyvqnzafmZUGRZj+ZrcVjlEX4ts=;
 b=SDLSmo2wKMy3G0wdRwRnhCraAm/jxNX8gnGggCpNAwm8tmbqI55M+kYHLffplKdw/UeL32Eleo3IxfFEDHxPkwDC4EbFXe8wNlT5w3Z7eM/orLAd0ZW6YMptEphytZLa5W5O+2b4MR+dceIMV5vPFgv8J7/Xln4hX9ezKy+BQrs=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 01:02:58 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::1b3:8ca1:e95b:22e5%6]) with mapi id 15.20.7292.022; Mon, 19 Feb 2024
 01:02:58 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "bp@alien8.de"
	<bp@alien8.de>, "Sharma, Deepak" <Deepak.Sharma@amd.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH V14 0/7] amd-pstate preferred core
Thread-Topic: [PATCH V14 0/7] amd-pstate preferred core
Thread-Index: AQHaSrao7cru5/jeHkCV0sSINFqsALDw90UAgAAEPICAAwoUAIAcbvkAgACUhQA=
Date: Mon, 19 Feb 2024 01:02:58 +0000
Message-ID:
 <DM4PR12MB6351F882F2AC0AF0E4F2CA22F7512@DM4PR12MB6351.namprd12.prod.outlook.com>
References:
 <CAJZ5v0hRk3tME7yeC+1r0RM4-oPPrnSu2=JCsOshBbJp_Nq2Hg@mail.gmail.com>
 <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
In-Reply-To: <20240218161435.38312-1-lucasleeeeeeeee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c5a92805-7f4b-4203-85a0-0f6b08bc26ce;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-19T01:02:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|MW6PR12MB8833:EE_
x-ms-office365-filtering-correlation-id: 693e7da5-3a40-4cf2-254c-08dc30e68336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YyYJId9hyxaMKtYGaGOHG/cY3uwBFMuA9YBQuY2RGY6RQ8/m0mPopcMmSr5baTKurcHv4/l3CgBFbW49DajDeMYzveMSbUtdkcVQgvhNHEq+BShKVQVy+qW4LjSCve3E8cwqjdSvrHcgiPHnXwELUfshW5vBwI13KFDsrSpYJj0lr46d8hm3+sd9DLZliLt0q9JrZPLAcarx8lVEicpTyRBsPec/rBG9fqZ2miqdyEJHsdz8YBHKGBVTVqvnxdyrR7kpiKIGs7OrrW63bLAeidxt8T3ZB6uqGxFkdesUa5fHmGVobsZK33ZjQkIR/6kvapH4uzowiIwiFibF+ZvO+4n+0bs3VP8iU9OHTgQGhDAlJ+KOkb1fv3TK7TYips8CSSdfAsolOjlTnwFORwWN26MWXoK4X0w1hTTC45TNKqnaXA5vOuR8cL5AzzQCzG4pKla5mUJEm6nsLQrNu0dVf7mgf4PrO8KGJ2dV/XAkvlT7Wjd7I8l53S6uYcfYyA+MlBYch/dVXBwsbIELY9WYXZcXbGOrUznuQvUAL6BQm2xAeX65go0gbWe7gghnyMKDGGPzlknCyjpbFKG+BdW34ZFst3GcFttqVFUmJtREHH94tBOo7p8o5GZVlp1+T4dz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(110136005)(316002)(54906003)(41300700001)(55016003)(7416002)(2906002)(66476007)(66556008)(66946007)(76116006)(5660300002)(4326008)(8676002)(8936002)(83380400001)(86362001)(52536014)(71200400001)(478600001)(9686003)(66446008)(38070700009)(53546011)(6506007)(7696005)(26005)(64756008)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BR8Pvx/EnunxnE6DKiuwNJQG2DL+jI4yvNC7nWKgD4sCHM2hK2CdTJfzZ4Vh?=
 =?us-ascii?Q?9vZDrbceWsuh0eG57rQK+6gJRV38oldBBOzol8Gmw4It1P4VsC89UqXNj9uh?=
 =?us-ascii?Q?DnGuP2lf5onrxE4wN8Zvij8f/CNWQyOp+r7h8bkXrIhwVln7uxq5iedVhKPa?=
 =?us-ascii?Q?4qdvwV1pKeVe8th7WXQL62Mr61ugNHpVFRpd9RJaAXAYT9Kr1qzAJ43Kn5Wc?=
 =?us-ascii?Q?EOIHga/YduZOwnXlCvIDrTQCmYCXcCRFXA2S+ua8Vw6hbUlkdnQsxp0DIPtK?=
 =?us-ascii?Q?w5R8OszIRvgkMFTKGENZ+1iaC3dBa13RDxnbOgXnLpYujCLffl9QDL8ufcDp?=
 =?us-ascii?Q?T36ROfxtXw1e0kArFddd4jHzViTeES+ZDf+RniUXOfR9oeQEuuXVfq1Wfyxq?=
 =?us-ascii?Q?NwOq0kNa5CQM64B2/sTAQwn+zNlHfsMaLia98uvbEggASp33oQOKzr0LmNQo?=
 =?us-ascii?Q?wPCAp4e0fF6TNsA5FOnuanUqnOamZXeE74eA2zo6PYSg2umJZNb/t0T2YY0c?=
 =?us-ascii?Q?j5iI6LSUH0ICcz4ORbJLt37gJ0ToQkgs9unAKtfLHmguGozVXR1uxa25WEar?=
 =?us-ascii?Q?iMII6G3xTLAgPzhYpKNg+6RaHA0YA/5RA97rvcYhRczfBU9zZwRUkKgS7Jss?=
 =?us-ascii?Q?G46e6dvrivq02DhyQogjyrRi4cviaeAoKdamz0iZKpxnKcXorRXxMnvY1MF4?=
 =?us-ascii?Q?H5AjoPkB802z5q5u0TRq9p+w1Gw9bbwM+LIJjH20NtUYAnmQG4FdQizzoi1i?=
 =?us-ascii?Q?pAjgSXbIEnP1TWDIlwC0L7RT1Ciwx77ShOKtFrY9br+3j+PqY6giQLdND7yW?=
 =?us-ascii?Q?Gz6t/YZ30NKGwVlGvSN7YDD8Bc1fKeRYNWw/3Os0klBoV9oTwAUMHPrqf24w?=
 =?us-ascii?Q?i1TLWG4XNatJECkf5Y6DIAtNqD2oGkjcjkyjzl8b22Fpj1NJqK1+iIJJfYDu?=
 =?us-ascii?Q?Ou4eVzQgNmNBnZpLYMMcA2ZQYaFvAHLAgVFh3LcLcfVDdBD5ufuQ/x52vivA?=
 =?us-ascii?Q?smPzE33UHQ4IEbqVmAP50xc4q7BrbH4qDFIDWShLwH+HgH7GMQtDBWdpnY4m?=
 =?us-ascii?Q?0FNapaaeE90xhDw970zVb0iY2xQSQ3Q4j/G0uI2aRbiIljVcjZZZ67FmcGw9?=
 =?us-ascii?Q?ShFW1hB7xqa/pZMXYW+2jyXUB2wI61z9evBw2wwWHIc0vDryijMp9Cm7HOe8?=
 =?us-ascii?Q?ZFCE+aiv4bmfAi2oYu/yeKSYi53zjF/4yWaa13HES6AZECuqSMjPYcEl1zVp?=
 =?us-ascii?Q?CUaiI7yf7gbgmqG+6x1Vg3BVoZ00OTWxB5xArdc/BgkQhIN6I8qNArmej57s?=
 =?us-ascii?Q?Z5o5Je+SCQ1sOrFG1OH5i07u07HTd111w3VmmJt9YClESln10fMoLl5sN/8F?=
 =?us-ascii?Q?YPWHUUG+J5lLKScTvMPd8YvOfY9PrV9ySn5OuZTuutMsM3Z1buPRq8eAXxmY?=
 =?us-ascii?Q?BJhkn19oYlTHmDH1qDaVNtBFlXueUIR/pEVNOaCKRhbWhUEeLqpLLUTpWlni?=
 =?us-ascii?Q?eFcZbd4TJWM3rYUTAGI1+nvgrFKuEm8CCgIX92xfPi8Yun1cS80rsluEHNSS?=
 =?us-ascii?Q?EsFYc3/bvSDgFyco8r4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693e7da5-3a40-4cf2-254c-08dc30e68336
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 01:02:58.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNWXtYPb3LSqewl561V5cuCc1BDullAALoeJ1jK/yojbBBi79xwIlGOpWevmlYeBElOV1/LhbvV0LUPbvTY6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

[AMD Official Use Only - General]

Hi :
Thanks.
I will check this issue and fix it as soon as possible.

> -----Original Message-----
> From: Lucas Lee Jing Yi <lucasleeeeeeeee@gmail.com>
> Sent: Monday, February 19, 2024 12:11 AM
> To: rafael@kernel.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; bp@alien8.de; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-pm@vger.kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; oleksandr@natalenko.name;
> rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>; Huang,
> Shimmer <Shimmer.Huang@amd.com>; skhan@linuxfoundation.org;
> viresh.kumar@linaro.org; x86@kernel.org
> Subject: Re: [PATCH V14 0/7] amd-pstate preferred core
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> Dear all,
> I have found an issue with the patchset when applying on 6.7, leading to =
a
> large degradation in performance.
>
> On my 7840HS on *STOCK* 6.7 highest_perf is reported as 196, not 166 as
> assumed in the patchset. Applying the patchset causes highest_perf to be
> misreported and hence a misreported maximum frequency as well, at
> 4.35GHz instead of 5.14GHz, leading to the degradation in performance.
> However, On my 5950X, highest_perf is indeed reported as 166 before and
> after applying the patchset.
>
> Hence, I propose the following patch (should be attached).
>
> I do apologize for any mistakes as I am new to this and this is my first =
email on
> the mailing list.
>
> Cheers!
> Lucas

