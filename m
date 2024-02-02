Return-Path: <linux-kselftest+bounces-4033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38749847990
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDFB285096
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B315E5C1;
	Fri,  2 Feb 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CU7hGChW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lx2y6UEc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C515E5B1;
	Fri,  2 Feb 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901738; cv=fail; b=XhzNuDIYY0NSRA/yqDvr2y4/prnks7OMcyPoYCY0aKbp8PXwNrHlrvwDEgeyRUGlSCxmzZeU9WMf4Hs0824bQXzZxQLclp+Qqo6y2ymdroxjW5qon//nfydrnIGuQ0vpLJnb/lodMOePfuNdzf7kKXIpIQIlZbnvLJUdjbQnSLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901738; c=relaxed/simple;
	bh=3FJdd8kjLwSxgw2KxuUcc430yGpK25AZn8x5EHWt47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UhzXdbM1SlK5QzZTdoamTQP5e7I8DpuPuqNLZBUVLw/97qxDdH7pL3Q3kzv66wYWVLatvGvOwKHBMf0B97klebgGA56hS/ajDIteU6ry1UWiA3NyTZNXQ/SHMKCETx6HlzCSwGzh0IoMojCDHimBkSwACYN8b1xYyVrZ8Z604Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CU7hGChW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lx2y6UEc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412JEUWk008235;
	Fri, 2 Feb 2024 19:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5VW6q2h7vn9uub8h5220ORRrVuVPIyxmjvpOU5Ej+fY=;
 b=CU7hGChW8W+qDcB46hzwSKANy8UGAOzUY5puPSm/1OsT+YYJNe+FxWntJrUd+6HT7Wbb
 aj70utf3Qexeeo1656IozK62EqgZA7ahR7rRV5wxozJRhEauq/KB1Yn1EmxpkQYa9a1s
 ktarNBoGUa1clmNvYGS5u4aEqsQf5iflCkAxwkyrZetXA18RP/SmmeAMxgKc7JGm28wG
 GQaNWwr2GebHmz+adL8xSF9Hn8LBuc9JRe3wl1oQ7eTIAUHmVH9jwXigKba+EsZlWaYo
 XyKYMaRH22S6Ajz7ooL4860ZbF6spOdv/o2X+gr7lDhk7/puWbJCwaSslReDdgEp2vbm aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2rnxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 19:21:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412IDZ84011830;
	Fri, 2 Feb 2024 19:21:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ctbvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 19:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiLvhfOhd7AMo2g1kZHsiBZxVIGe4R8oq19HBflHV85Q9jTeaXGHuJ1HlBHQUigsuHjZ5bjlnpZiMU33Qb9IsYvCFudBNC99GsKQNKYNzj7oMYVXXBaTthlguO15SJQbVB6+pltS8ibDKWO6l/ZedQCdGK2AaLVc0tviXk6E0b4YiymADbsGM572epATuIHl4L1weQT101yN2hlqBVAVr6oWE+4mVpj4n27uS2rOs2ENv9FyEgZZDyGBv7q3ByQKln+zG7bCj1F/PB5tciKCWdCBHU33MB2OuRpDtdLiqKIAGP86OSzvvHIzibp57gYh/ZtEf3M70Dc244gB+uITog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VW6q2h7vn9uub8h5220ORRrVuVPIyxmjvpOU5Ej+fY=;
 b=HUSTDYw8YgV2rOBSEFQ7WKh/Jo3xeuHxmGJ8cqS3ePDhsWbJJvT3sn/POxIBfW9bDc7jGlAK3TZUNZMPGn5jK6bV4LPXa1Oa4JyQpGaW1p+szRgI9MGfY6gsXIQiPwavKBrlZpnbhddFjU6essMl+KkaLvw7GFX2O7DhO8QOvXrS5sdQgoEOYmzpacWsPHpQcX63zLsbpwgiH77vHFc8sGrSp1071gGKdEG86xuDqBRzR9IRm7k4DzepKS0SCP00Vc0E5yOwQQhl0h1OKkOeeFCSNa2C8ZRao+JhzGzAXrF2TWiMS6ikoqOQGuSpheJp16ypysEB19ZR5+fWNYhD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VW6q2h7vn9uub8h5220ORRrVuVPIyxmjvpOU5Ej+fY=;
 b=Lx2y6UEcImrUASplngdmtfaKKa7ZxwC+ZI0WPUv5h9Lm2pghzB/Dp4YBs9tMX3eaClfdyQPiJZY4VCsaiMS7Z91z9HI25nq/CFPFeb68j6KkVFArSkFRwC1dWDR7UyHjDP18/XsJ4wku4PwyFtFtDUT0GOaPSx10qOFwPdQ1UW8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 19:21:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 19:21:40 +0000
Date: Fri, 2 Feb 2024 14:21:37 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
        akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240202192137.6lupguvhtdt72rbr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver>
 <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3097f50b-3213-4db8-e805-08dc24242e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UgK3wYj5i1enVv0RMaRxQtHpDfOmk/3Mt+kzHMX0CoaiBtP22+OOsJ0G0n+vyydezPHxhwC8ydXMyNrqv2fF696tYUiGfQRNBbW8LkblX2VcE/GoMnuEFpz4ce0UuNX3MDOZ7eo/hjwA1JuZIGFE6IVyH3/cL/MQlzbNamxwTWvslVo+9ruH/EFfKOL2CGdY03vyU/kWRoG9BFdbtGOOU2gbna6Up76puFAHzOiKbEZGyxO0ttriJ37NyzRK/JhCFNHN344RlPIE6z/ssgdaF8OwtF7+VoRi2xjSbkrPRHQJgLYkVr987Fe4Od4SNwaK8YyWtYr/TgXUNfUcAubsknF02KLQZsG5lljaJg2Ah2D502SQRZDM+kfiUM8rkBwLwBRNoFm2yqC/eUuiSobo7/Sw8I0r87cVZ90JysFb5zhrPtSjOMNvHP8t02PerrzG+/1nFp+gQnsMsSXOHeiFJoJHPCN6nuR/s78tP+4UXyrkoXi6OmFzIo2xaY3apWA/oyOpZiX/GNvHcAt71wjVGaxeu31jdFhT9IinnTnqew/sHV0iE3DVyflHI86qu+by
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(9686003)(6512007)(8936002)(1076003)(26005)(33716001)(6486002)(41300700001)(478600001)(316002)(4326008)(8676002)(86362001)(6916009)(2906002)(5660300002)(54906003)(7416002)(66476007)(66556008)(66946007)(6666004)(6506007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DLZwYDMspeJ7da+DgJJfWHDSswMdhuArQdcr4EtsZngqygLfAx1qXyKzgG7h?=
 =?us-ascii?Q?KW7RFMqH0GX5gziclXJW64YLmCV4QXKRx8J4D/oVq8RoSfz1SC3fgwXjui7T?=
 =?us-ascii?Q?ksKwJzzYnSeZyZortaeyYVOIsJwzYs0T95oAxD19doBrtTxNxKbRlK3cIPoy?=
 =?us-ascii?Q?+agteLUW4eeOMPcXsueWDG0Mz+VjOdCIenlwnEIEyR0sv6EKYFR0RR5es1wP?=
 =?us-ascii?Q?vqWNi6dKaZJLeNu8lLvL/zEXte7ce4woqLrDNf1EJWkfOdu+VcGM2Uns7GdN?=
 =?us-ascii?Q?crPH3smcTAWXGloFNdKeUEDly2emss51ICrxWcz4pINTkB8DpVrfyM3UECba?=
 =?us-ascii?Q?FMWVb3UPCtrn70IcgrHaSflvQbLz9921SMfcDGZVuLaaptW01i4NJStaqvvT?=
 =?us-ascii?Q?eeBOinvR8KazZs4k6N0rvsJ556CKbcjcR2hFtTCOnXhL4bUXkvgBGSYYk6+T?=
 =?us-ascii?Q?VkDaQVQjmMtNsFwJ78tWEqH8bNSTwvLGtUt2/eZE2xZBRbUVgprlOAARTGYE?=
 =?us-ascii?Q?DvmNOf62duhmAkKykacYv4F04R0cH9FtbrAbqB6CrU6dxc6HnAGIe3T9lYqU?=
 =?us-ascii?Q?U4G4zkF8aj+YomFHasJnH4kT6mnqpbTPBR83hzKIY09bE1EhG9c3A4VFFepB?=
 =?us-ascii?Q?ebm2mes/r+O7XYEHzhs1jPHTp6VK85Q8zqTesDYrvfW2UdxflkP/to7ueSL1?=
 =?us-ascii?Q?/pZDnQj1YeGiocJ2Pbz03pRLQntCIIoTA6DDmLhvpCS6fLGO6yiEjn7BEjKt?=
 =?us-ascii?Q?zHHNGUyEDVuj6+kLCi1b6HHu12pAtUfavVeWl8iSc0zfTaZPorih2w6kuuBH?=
 =?us-ascii?Q?djd4/87c3FliYBAJHL6pmJcQzjitSkQAJrxWlVeXGGYFplFo0yg9Cuut+aRB?=
 =?us-ascii?Q?ABquZquX5r6s0AU/LtTtjl8TPlMAyyj22A6UQ+YeiMdNMHTqhy3OY37FzsXn?=
 =?us-ascii?Q?cwqGJrlObG2yZ8lJ7vTVF2p5twZLsn9F/fYVZJYZQyTOyix/ZQ1nUe4WQgzh?=
 =?us-ascii?Q?3km0tvqJdHFFqx7DAog2DLk2UcqJsPwp67vxpkl38+PoGxLO7orZnlde6iYS?=
 =?us-ascii?Q?rlLpmxAxkqvscCJiQys4AtP9vxziSjDnAPZfdHEyR0+b9B+5LbeKMgUhokG+?=
 =?us-ascii?Q?kSW3vYEI2lQtyugA0Boma4cUxv5Wtt8Xh4xrmbAdAUe/o2GjsSnpApvW3ukN?=
 =?us-ascii?Q?vOhu8cxycMepg5mlq01ohiFcmNWCZ2+XkVHTlOGhP9/d7npriWbGelAHH/St?=
 =?us-ascii?Q?dr4iozpYTdGzsHMfIiKW+i2dIueuHOtd2u20OFHlBP2EF3pnq4Ykl8MeNk+J?=
 =?us-ascii?Q?vo2i92pfln3Jv/domaOWqaFBPurFwGkdKUatZZyv5vwRSOJ5zSlgQ3JbHSCi?=
 =?us-ascii?Q?NfCdMsSJGo7aKgeQs4IBZoZ4IqZhDy/m2JeDQed4UreciGyE2gaaHtgi/cuw?=
 =?us-ascii?Q?p5PxRA+doKr61CInaoO3GrwtEm+F0lm8kVLYjzhXr09vUd+NtdlZf+P9zDgk?=
 =?us-ascii?Q?ggq21ewjwvUuT3vLkmk8TOpm9vQnBUKt3lkmfUDpsFDRNj4Ll4OIQX/VToPx?=
 =?us-ascii?Q?Huh+kcw6ungc6WD9MrWfCKtD+GucatkLTzn19IIwyFDE4HCWYknxhI/a+3sI?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	peBma6ZZPUVp+QvFNLr1Fhb2HE/koBVR17OMS3bKd5rl7zaqrB+GTVt//wk3s7DgBmmaniyhi7F8ScqKatMqe28euW0zky1N4PVxQTSA8WaIchzszcJAGRRdAxWJIS2PUtfXzA7rCjrlipXKFm+ykFCiocit9DjHnQWGzXrrMS4RIKSvsl3SV6kaVophFXN+x/4JMnidRrczlq+wgm1gpfXNE1DsDDm4ZVwnQ68LS8kCaTnqqWIPOJFVZoaI+T94HLyHKsqBwClxX2zJIZQVkfzTmqN6SM3kc30Z8Jsonl1JmSoz/FSWXlpNW2uHgMZVPFxF13W/JXlTaQHOk5kUMxv2nyS0BfVWHn3cpET9LNWRewf5v/yZ9QYZPEh70kukrWi4Eaoe+79o3/hahCwwemttqVrLkr8Ib6VmnnpbvK4OKFhPH9qFRGPBKPM0vh96zW2jt3dP3rx5d4btvAIGYFiWBWZB4nFU4oDH1PGbCmLdHmzL6Zt1xSpI2plU0CLZJYCbXi/ezPQcSdUHMe9PbHJO25b3YH8b5hFmhRAKgLdtd7A0Eolc6ocsMFCi7I50nyUmLZidR2FF6fHmxn9aYDpzEwWgSa8B71h9lo3m6rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3097f50b-3213-4db8-e805-08dc24242e96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:21:39.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DqFJlC0t97DVY9fFVEmFSiuXPZRsvZj4I11Ku07MR3OcDftiHtfYYrOWixFbuTWmgnkzCTW9PqtOf+pYh/6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=993 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020141
X-Proofpoint-GUID: DqaPrQK9rduC13xKgmjCKsD5ivhWP3zb
X-Proofpoint-ORIG-GUID: DqaPrQK9rduC13xKgmjCKsD5ivhWP3zb

* Jeff Xu <jeffxu@chromium.org> [240202 12:24]:

...

> > Provide code that uses this feature.

Please do this too :)

> >
> > Provide benchmark results where you apply mseal to 1, 2, 4, 8, 16, and
> > 32 VMAs.
> >
> I will prepare for the benchmark tests.

Thank you, please also include runs of calls that you are modifying for
checking for mseal() as we are adding loops there.

> 
> > Provide code that tests and checks the failure paths.  Failures at the
> > start, middle, and end of the modifications.
> >
> Regarding, "Failures at the start, middle, and end of the modifications."
> 
> With the current implementation, e.g. it checks if the sealing is
> applied before actual modification of VMAs, so partial modifications
> are avoided in mprotect, mremap, munmap.
> 
> There are test cases in the selftests to cover the failure path,
> including the beginning, middle and end of VMAs.
> test_seal_unmapped_start
> test_seal_unmapped_middle
> test_seal_unmapped_end
> test_seal_invalid_input
> test_seal_start_mprotect
> test_seal_end_mprotect
> etc.
> 
> Are those what you are looking for ?

Those are certainly good, but we need more checking in there.  You have
a seal_split test that splits the vma by mseal but you don't check the
flags on the VMAs.

What I'm more concerned about is what happens if you call mseal() on a
range and it can mseal a portion.  Like, what happens to the first vma
in your test_seal_unmapped_middle case?  I see it returns an error, but
is the first VMA mseal()'ed? (no it's not, but test that)

What about the other system calls that will be denied on an mseal() VMA?
Do they still behave the same?  do_mprotect_pkey() will break out of the
loop on the first error it sees - but it has modified some VMAs up to
that point, I believe?  You have changed this to abort before anything
is modified.  This is probably acceptable because it won't affect
existing applications unless they start using mseal(), but that's just
my opinion.

It would be good to state the change in behaviour because it is changing
the fundamental model of changing mprotect/madvise until an issue is
hit.  I think you are covering this by "it blocks X" but it's doing more
than, say, a flag verification.  One could reasonably assume this is
just another flag verification.

> 
> > Document what happens in those failure paths.

I'd like to know how this affects other system calls in the partial
success cases/return error cases.  Some will now return new error codes
and some may change the behaviour.

It may even be okay to allow munmap() to split VMAs at the start/end of
the region and fail to munmap because some VMA in the middle is
mseal()'ed - but maybe not?  I haven't put a whole lot of thought into
it.

Thanks,
Liam

