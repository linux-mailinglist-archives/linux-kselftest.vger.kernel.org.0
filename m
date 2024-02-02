Return-Path: <linux-kselftest+bounces-4049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84534847B6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A920E1C21BAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48F8063C;
	Fri,  2 Feb 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sp/lQEJS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7sDGxu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAC18049;
	Fri,  2 Feb 2024 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908728; cv=fail; b=VNoXAtG3OOXsBvfuM9k+UBi3TProDCd5uWvrZojuJsg918j/0XyUVjsteaJOqIsz8xFrA1tQuTTq1cOjEeNcPTbg+d1iSiBdB7FEU2tHbFqbtDFSNlQ5jyJ+vzIoFa9kOXxR2Kb1V+4RDK3309X+4ltYrJFicaaWoDzxsYdZqQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908728; c=relaxed/simple;
	bh=aBk1RGkdnccUsv0TvdDIjAbkcPt+dOJox+3NVIb95OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZAdHmonbaPbJolh8vY0CVZJxPXa17R/CS5WnZF451l8rA6s4QsH7GJhA8Sk+CbgitcY4iO4X0jVfby6d/HFsIiQ95exRe8KsLxSigVA/8VCCtCqslza59fqMINRz2tow5xAi/vxYCkkopcybF11Xsz6mJn27sKeEmonKUeDRssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sp/lQEJS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O7sDGxu0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412Jx9Yr002020;
	Fri, 2 Feb 2024 21:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=HavuvWtktmTQKcK1Ku7oro+2Pg/aun5qwLivZtzU+lQ=;
 b=Sp/lQEJS5yU1dyWvFr8Y5WBBI12nBGt0Lh7Ruoibg7Lh2o/2Nl46VTh9+fV3UKnd9GVY
 GPkus49H2oWkHGGs9ixAjnZIPNT975tflwlEZieR42vtHafhpjmEot7tuAuahX7Xw5w/
 vdjjYoaGzETN8JPdMUyYmmJIpJY0INYvZiEjCp3KWjzb1y+t0tvXGXT8ruKU37b5vC2l
 eWFVr5wMCrqHKPlSYsc027JAG9++RxvP5wF46gYdMc0xB3w50EoZj3aXRmtbBHD9gZDj
 E4/a3MRUJpyXSqGD34kbMZsucuaTQbxbxJYRfcfCTFCAQyPt2Noahptn9bF759156x1P cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8eraw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 21:18:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412K27u5024539;
	Fri, 2 Feb 2024 21:18:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9cepxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 21:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhFXWGTPdIaotQDDNwAw3Ba6/YZJ7pluF8qP7HQZmWuXN0c4+qNXPddgVb5rZMoKKAPT3nqe6BEqL/ssTW3roAyxsb05viwoHUl0G1NFAnrdDjX69LiDTyL1ueesI4fROUS3hLcoAIRAKKwet/C036srJSdyFuAf62W4GfWOWWG5uWNilm5FswgvHhY0ZJmpdfKP/PbSJ0xWAt66Ad5z9rskSzXfduGYg+rZ2vvIcysGyZyFpQQmtNoafJR2zsOT6+u+aDW2AyatIqx3XqdsP0Fw0AuK0sJS6ZDPYimEslJXYHcbwXGw4LN14EpIjBvp1106mrPLMnpIGDP6tf5o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HavuvWtktmTQKcK1Ku7oro+2Pg/aun5qwLivZtzU+lQ=;
 b=BzzCnf3PjnIeaGgpGMK1uGk08oAoF4WN3qBAnRCFhm1CGjj/nzvyyo8nje58b7uLK0/lY/0FDfE8TdJrfb6uYpP3UhJg/F5ystlX67WiJfLuzeCD6F+NF8AZEU1XevvdpxbAFF8fNKljkAQyhtdZlJDpSzzfro5QfzcDkSNTWHrGnBS+HggNHEeOg+y6n5CcmGKMUr82gt5XcOvlptqt3oGiWE/WL25frLz6VznPlyqD3mGoHN7sJD5g5VVd7ilbZ6RAv02AURzhM8u9Ik/9fo2Ss6wCh4A41TB3tWLBkhJsT3r5JXvW27OiZVfdluZbdSp2HSzaHLSb6LC8ispWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HavuvWtktmTQKcK1Ku7oro+2Pg/aun5qwLivZtzU+lQ=;
 b=O7sDGxu02jnmoby4yR0tytckvadzv9NaTdzD8QI4XSplJJTm+Cnp6b1KAj8iu8MAL/OaYucrfwXqu2igOh31t7cMo4xo+/Eb7WRhuPWqahCSX8E7NveP7F8+KE/CWFG48X4DQIPBdsWIE2S8Hg32Q8Vb2tVXe+yPFsQczHIic5o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYYPR10MB7676.namprd10.prod.outlook.com (2603:10b6:930:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 21:18:09 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 21:18:09 +0000
Date: Fri, 2 Feb 2024 16:18:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
        Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        usama.anjum@collabora.com, rdunlap@infradead.org, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240202211807.6sca4ppezma7cyev@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver>
 <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver>
 <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYYPR10MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: d1130262-650e-4a91-bb85-08dc243474db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C37Og+gqyIOUarPfw/CV6wo++jOQtYiRhXe3/SMYZC8SArccvaaAIbaRHp/VMGwyri/6brBGhFo8RYC8vyMbooMnsztWVj84QWgcUOIAI6rIJrJu0J4K0+nYuvvw87dPbLlPFBVui+gdKJ3h4BrqXIUkmr2HOneOFZlDtJKRhyPosNfaXTG+IvkUEPRiK9FZ48K7WpxwMr++SdgTrgmlRXM2okxqRNovJFWjchQh3AKQX0Le2QocpmLFH+wgQuUIowUbLqS5iCYHAJTtsA/u2cRj2YRCm8i6pjf3Lb2/bTCv64nl0zOx4by8WWEYbte7UlCST8L46r8sOtrrEvzsXdcI4fYMW5OqI44H9R094YuIQdC3a+5E1xXSFn3n4DPoAQdkbuwVOzhkTyZrkzV67LE3XU8/AMR3TW3PTaxhR/sm0iWd8t3Gm6KJ6c7Qi5f6+fPvCEvBmZ80nU+hQefaK4QdOlQgZPh3HXBnf73RpXSzeyVl9XFNGZiROrSk7Lk5dO2SY9SosDE1RBkWzd4vD4Z9W9hIGvxFjXAPeZR5DsZtcHWme6Lvx+imN4rzUSpQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6486002)(26005)(1076003)(41300700001)(33716001)(54906003)(66946007)(8676002)(8936002)(4326008)(4744005)(66556008)(6916009)(66476007)(316002)(5660300002)(38100700002)(7416002)(6506007)(2906002)(6512007)(478600001)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7gIHTt+Zh9sOIph3mc3Rkp8+FehfyPymCJR/kml5+9r6m9ZAzEi8DMtorRuf?=
 =?us-ascii?Q?HMttPXc2BbEHN5x/6q5E0TN4ojyqOm4j0WGIH2lxSAHb2xoaXYpef7Xt+UKr?=
 =?us-ascii?Q?DWDAa8FaeRLPNNymUX2IuxY+QhSegQ6JTkutd+sFcCaJNCCKIEiFjPEW4S+F?=
 =?us-ascii?Q?NZFM/T4zC6AWCn2CiGJ0LMxE8xlanu8NUwFukZWPFnouUBw3y1HBCPb705p2?=
 =?us-ascii?Q?negOO0A4hkmlsE6NIQGXKnw4aSktF/dTSA/druMwOnW7jYSEBUhDpiSKHtMo?=
 =?us-ascii?Q?ijM4FLd1xlhmpRrvDrpY8a6GeAzCj79xscjV0o+azETvvk0qc1jU9Oiqi8pW?=
 =?us-ascii?Q?E4ElZg+utA8UwFkzTSYH/BSS/T/DEJNhth3GdnB+xTe44zpHjmyh0rl8vycJ?=
 =?us-ascii?Q?vWPSMK2GjPLyXtS0Z7mlVSlau0xgFbIrsYrAiBNutI58vZF5ohazytylpoPB?=
 =?us-ascii?Q?ndowLT/qxpNR4f2fCOQ6JkX5FEQ3l3zA7lYIBL3+DY+euz8R0pCF6RFpf0hs?=
 =?us-ascii?Q?jsqlah1g5ghxJCLYrJnxCpyNjmK5HugoMFjaCTaniUkVgf+wLcfWug94arH1?=
 =?us-ascii?Q?0I8uCvmaCkOxETPFIppQGVLghE8TFyha10sOOhWBwQ2m5M9MsmjYebcXKtrq?=
 =?us-ascii?Q?9CSMix0HfoyK3B3hm2S4JgUiEBiQjEIgyQfn0qWJaj7QP7sjC+bobhMfAhlh?=
 =?us-ascii?Q?BwdyhavwQzeVO22aQwvRH2S7Qt8hG9vcq9EcFmjwMGuvsuPZOZHO0thRp7iZ?=
 =?us-ascii?Q?YqZzKEuAPFehvkZu0WVuQvDo4NIIFmIgdRnS7RY/xNWSqorDMpL2T+BQLk4V?=
 =?us-ascii?Q?V01IiLRrQSRDUOR8a506iUjbJHweaHFWO5oGHMigOSIrsfT++Tj9VN4dJduq?=
 =?us-ascii?Q?rvCvA2O36VnJmGX6N5UPfS7Nb2tweRniWm1LYtbI+JArkKB82RrudTTZd3tk?=
 =?us-ascii?Q?X3v1SMiksBA3kNFKp9lKnAzWJ7gaK/Eo9m083kjHAyMdQfMn02csm+en4zVI?=
 =?us-ascii?Q?/Zj1EoK6W0ml34HikWqMV+QsSRddjr6XnswAuwe1N5vmyvaF76p5AqeDOeAn?=
 =?us-ascii?Q?SBtAgFqRvluPS7GpCPERGaInOVMa/O1LMrU+18ZXqBPvT/omVhtXPjenovYd?=
 =?us-ascii?Q?eIZDxBLibTS+7OPr2Jb9Wl6M4YecLMyJ5EpUILbPL2Bk92rrY7uXFk0Erj4w?=
 =?us-ascii?Q?BBVjAOS9aJCFY04+ro82gObE/7dZMkdcwC4jBvpEo8Ur1Ojrgy3/G0hyvkXM?=
 =?us-ascii?Q?6Qh3vUVLpCGL+DvArBlbz8eIpBkhfWMkGrDaL2EYiq/wkPz2IAXMTKxuNU+/?=
 =?us-ascii?Q?VUrgM96Cwjio/RjK/tEzDHdt+5X12mBLle9gRMk2/At7l3lnpVbfIf5VB/Tq?=
 =?us-ascii?Q?WbC5Tve8Q5h4cEb5YgEeZvfSc/hmvIlESO/jVWlLh4h3qtc8jOyoIvrrvxLW?=
 =?us-ascii?Q?6osTGYZuMD55IpdgyxUb2wRpRSEzsZTpiEsn0EMrvHgnR6CtP0B1YZ2o8j9z?=
 =?us-ascii?Q?anRsD3DA8LY8tIc4VnLTldw6wb4gVUCDgmPGTaDKT+tTuQM4x+pVrWcnFkF7?=
 =?us-ascii?Q?SNdxZPRL/GS0k0NsWx1FRt3Z9kSZlKjQvWpWZxstOqhBdiwPRZCtQaHWXw7E?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0sOffcCgwQ2ynSbFFEvZEDakeHYZUXTUz3d+BKyQAWMCYDCFv2gpxOt/E3HLAZFPwo7+aMKWtqFY1yTan6ToqhoWK7EE5FqX7E8AdYCjrZMl5hWVWFKtUV7voxltSUl6VbIYHQ9Aln/Ie6tkDM5opqM9ci48ON4jm4qGdADzVKQ+AAuEXBWDRa2L5jkMzOwbF5GwrOv/yWrioDxYlHGVTxQKvzaV6yolxj/94LPLDywdbvODkiQklQ12Av8kemyXZSmbESBBYu27Xh9ChrDe/FPkjnWY43nkO1y/5Kzob1IfBlgPOvAkPURb+OBP/Mj72/qYoX8kqm+/LN6Ltq3oeEI0mLd0M7PEvI6ffoStxKpeJn+MNcQgFQ0dtx5qR/tbisoGa6PLGkJvjmNpirhUihHMh7oGizaGRyokNhPjw3c77J8AdUgFKTZxX+bBNPdLW4ibtFnJpat2Rg1j/M4R0n6/dSzfWGT6LCAe8zbuWM8JMmbTBsfUJu7lAV1koVJg9WVYKqqUO18I/9jfgbUWabIC808tgwVKdGkO6AwJsWCwMi9qdnUsDqnR3tEQDyIXuwnM/3Rn4klfyfUYSwIh7ymw06z8hPPc5dLkzgYkKlo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1130262-650e-4a91-bb85-08dc243474db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 21:18:09.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4itdf70xw4yZNXYEV1xuAMIx5mi0pvhZCNlZqDWeyM4jroQ61GYw59IrTcNJQ5t/KpcoE3xbWF3EqXVkeim7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=500 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020157
X-Proofpoint-ORIG-GUID: bsYyBNGIrwvuiZXH4IxQmv8CD62DDglT
X-Proofpoint-GUID: bsYyBNGIrwvuiZXH4IxQmv8CD62DDglT

* Linus Torvalds <torvalds@linux-foundation.org> [240202 15:37]:
> On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > Unix system calls must be atomic.
> >
> > They either return an error, and that is a promise they made no changes.
> 
> That's actually not true, and never has been.

...

> 
> In the specific case of mseal(), I suspect there are very few reasons
> ever *not* to be atomic, so in this particular context atomicity is
> likely always something that should be guaranteed. But I just wanted
> to point out that it's most definitely not a black-and-white issue in
> the general case.

There will be a larger performance cost to checking up front without
allowing the partial completion.  I don't expect these to be high, but
it's something to keep in mind if we are okay with the flexibility and
less atomic operation.

Thanks,
Liam

