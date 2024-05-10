Return-Path: <linux-kselftest+bounces-10046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3AF8C2A6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D285B21872
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF04642A;
	Fri, 10 May 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JtMULPt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78021EAC0;
	Fri, 10 May 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368921; cv=fail; b=uYedTrSHD9xE5CahM7m3cCvuUgKSXpuG/aWhscA9dhInh9X3T93Ob8vd0U+fgBmcdxazjgy9doJDAQs6BB3fIRoCnotyFzL7YX2yCIjEiUcHZbAuzhwiPSuBrpQnhcmJJ4nPWOk36DGFmYJ8hP+Gb4e6mCmdzt15zIKo0tZgUto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368921; c=relaxed/simple;
	bh=WvG7TBkFXNXX6e0A2EjLyGtS9insyDgCoLvbnsgNkNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYGFVaM5uXdNVsCxwZihIkWg5w8ffJsmTWxk8cNAkVHwhopG77CnFKZdh6/7ygNnJYxP1AfVRt5S5e4EQquOA6NsRKMW+xlqOvjav3G2ogxmSt7qUumgA5yVciZHmihT6FikXq4tcgfOVR3avLnG2HxUJrfS1vxYBmH3gDSx9Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JtMULPt8; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AInpug002353;
	Fri, 10 May 2024 12:21:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=WvG7TBkFXNXX6e0A2EjLyGtS9insyDgCoLvbnsgNkNc=;
 b=JtMULPt8k9reJUI0K88kw1X9YzVFSgbWAkXW0xKWdwIgHcpHS9nBq3ieHGpUrUEB6rlS
 ciJWqjDOb2q60uT75C5weiTdNPlSAprNJQFp8n1pJb4Yl0TQOnFXqeBzhPXKs7cCpxMF
 8ywS+RTOwW85uPE64bPLvi70SZ555ufAnetcBhfmSWWqn/vsu0qYb9pooILs76uy6vVJ
 GBR6orJWlrLfOic54ZBF8B9yPPfyOn93CfOejMY3yMaQ1g0dMdxx7Yxh7JwQFT9y50oo
 hBbc1HUgfSnTCfHv52OGDhGGNpeVDgZVTENvc+G+Us4vRtyIxJIX1aTv8eN2n4+NtfLm 0Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16p3wg4e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 12:21:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrGR+2KuRN0A4xDYsTa2e1R1fyu5JHYkcWryCBun/azA9L1mAD9UJxOdfNKKvbZMeM1RkWVG++h6DbRWiCTg2Au37EhlHnFDu5bwKRIFsGd71pmnoqUZOjuslYuFE3nhXF1jd/Wid4CB5SeHi0C69Pqcx6B2DdYZpJk4VCXJSZbRPdM4jCbzWVPGV9HfzSVtmnX1UNt48KNqbslst6D/GddcH3eTOwoqslaMiLw8BTLMxOFnm6Jp94p3WjK/3Q63YuWcq4BqCdJ5HMjA88QL1UU4FqxPD43ZfwwOjDC9/27uZblXrsgKRBqgR6v1BARBnmore9snTQUNVfhpocVg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvG7TBkFXNXX6e0A2EjLyGtS9insyDgCoLvbnsgNkNc=;
 b=As4sgwRtPROl5CHiSiGe0RjY7U9y/xwl8fkUSZgvfZfojZ3BJLkR+BgFHZE/aNX6GjVhcit7p/6D9dlATVLywgC3J64jHfg/BVoA5TvcnT/2+FbRJPpHo0prdwp/bnk5CN6GsuEWNEHDf2fN8P8w1InRmovBhAQE9QMuSMBs5ihSCP9zLI9dYg604oHWv2+9fud4Z2BXm1GnkIhgR5Ssm+24j0wKZSA3hQ0VOg3AFKeppt8WFByHx1lB6SM5RLxt6mwdCeaQHMlUiE/SU0W/9LumwDStFl03Gd9V97XFeyMawLV4EwnCyNbRz0TuPR5LLOZg20A7HRsXhler+VXZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com (2603:10b6:a03:37c::16)
 by CH3PR15MB5843.namprd15.prod.outlook.com (2603:10b6:610:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 19:21:49 +0000
Received: from SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a]) by SJ0PR15MB4615.namprd15.prod.outlook.com
 ([fe80::657a:1e0b:a042:548a%3]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 19:21:49 +0000
From: Manu Bretelle <chantra@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthieu Baerts
	<matttbe@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
        Mat Martineau
	<martineau@kernel.org>,
        Geliang Tang <geliang@kernel.org>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko
	<mykolal@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Geliang
 Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Topic: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
Thread-Index: AQHaoiihMJnNsDQVCEq70rk5JAhxYrGPOfIAgAFIGQD//+LlAA==
Date: Fri, 10 May 2024 19:21:49 +0000
Message-ID: <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
References: 
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
 <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
 <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
In-Reply-To: 
 <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.84.24042814
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4615:EE_|CH3PR15MB5843:EE_
x-ms-office365-filtering-correlation-id: 80ae3d9d-cb8d-4872-988a-08dc712670ad
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NHhYRlVvZVA3aVEwaTRzR3BWZmZkaHZsUW05ZXZScm1VTDBXK0FwckUwWlUz?=
 =?utf-8?B?b05JMmRWSTl0S2JpcnE5U25uaitmSmxKZjd2RWxGWmk0UVVMc1krMkhwSnll?=
 =?utf-8?B?Y3IrNU55VVlRQUV2QjIyc0l0eFdBUDBOSnhFUi9rbWQ4ZGx3Nng1WDRLTEJ2?=
 =?utf-8?B?aWltMGkxRksxYnI0ZTM3UHFBMVFRbnB6UEtFTHM0SWxISUs1bExOUnAxY3FO?=
 =?utf-8?B?aE1QaGh4dDJKODRoN0xGNHNNZTlZUCtuQXR6VUozNkFPZEFycytjd2JqUGds?=
 =?utf-8?B?bE41TkErektYanVpUlhTQzQrdmxyODBXNkF2WkQ3U2Vqb2NmNzIyWDhDL1lN?=
 =?utf-8?B?eGYzSU5KL0Q0c25GdGRpeFhzUHY5QlVRaU14NGxCYmphQ1QyWE1FRnpQV0dJ?=
 =?utf-8?B?SWtYSmNJMW9XRHVLcjMyNDZVMzNWdlJtR2c1UXVodUVPZVdGY1VYVU53YWh1?=
 =?utf-8?B?R1g1ampWV1JwaVEvMlk3RXowd1Z1bXFuMitNVWZITmdYakVTRER4UEtUVm5R?=
 =?utf-8?B?ajBrTlVNbnRKZlI3Sm8zRnFrdXgzTTIyRlBGd0lLbkJiNHByYkcyQ2NvSjRU?=
 =?utf-8?B?Zkx0aFZZb1lBZzUzTDd6VzNOeDg5ZUU4c3BoUFZLU3dPZThPOTRabjh0NFEr?=
 =?utf-8?B?NnRia2dGN0NqcTRFem80cGlXQjFadm5ianZ0RlpUdSsrU1lpa2pVTSs4WW5k?=
 =?utf-8?B?Z0JJUVpoemlKMElGcjVCcm50ZUt4QmVXTnpqTTk4N1RwR2JBaVFlVWhnTWtt?=
 =?utf-8?B?d2RvZFBoTVhsUlBzUHNoN3EvVVp3Y2JBZ2xCUDJ5TVY3QUhibWg3VkhpY2ll?=
 =?utf-8?B?aTY4Wm94cm1nSnYvQ2Q3cXFpZnhNUmFGNkY1T05NVkdjeVdjdUZ3enFST0Q5?=
 =?utf-8?B?d1h0QWV4VUpsdURSNFVCTVFhdUp4aTY2cFBleTJMcHZMTkhxbjBUNFhIVXpt?=
 =?utf-8?B?WUVEVnZQSFlrZjcxWCtqdHh3TDA0V29VTEFsY3orL2w4T0pzSHM2blRiMXR4?=
 =?utf-8?B?YzBGdUpmSlZKSGhoa0NKaUM2b0IvWjRLYVNYaE0wWGY5UlhydW93cldKeHQ5?=
 =?utf-8?B?OG9RMGtsZ25ZcVRkUmtDSTErRG1SaWJsRGsrY3I3OFhkZWxBOW1oMTI1UEsy?=
 =?utf-8?B?OHRWU3BPN1psbk1kMWc0NzVvK1ptZ1lhZVpZT1NnVzd3NVBWZkdkQnh1RkVj?=
 =?utf-8?B?NlFha1VjdlFrM0xUdTdqMStlVndQdVlST1MwMUxsQ3JPK3NROFdybWRFUjdq?=
 =?utf-8?B?N0UveHRDU3NRdlNkMk1EcnJLZGZtNGowWnhpV0ttTG85ckRWTDNPelNyZUF4?=
 =?utf-8?B?a21VUGNCT0VoMGFyajRoOVpQcS9wSVlqaWNzbngvVnNXY3lKMFFjYVpBbTlw?=
 =?utf-8?B?UGZQUzlxMmxiZEJtdVliNHJLY3NKV1BhUUk4cUZ5S3dsYW81Mzg1MEFIcUZD?=
 =?utf-8?B?ZDlvbkFJaWFqRkI4ODFlcis5Y2pURk83MmR1YWlYMUNucXdTKzRGODJoeTVo?=
 =?utf-8?B?aEVYWWxIUkFhcEI5M3diN2dJdWI3VGR6MFg4Z245RWlJUk1lT0h4UW4yYXY3?=
 =?utf-8?B?bTU4TUplWDBPK1JiN1hETTJ0cHdEc0J0NWxQZU0wbmh6VEVDeWRyK01EY2pT?=
 =?utf-8?B?RzJWSFpQQ0JKWWY0aW9qd2QzeGZaWDY2cFQ0ZUIyUnZuL09JQzdBUjAzSW5N?=
 =?utf-8?B?cUs4WTEvbWRrSFUrWWNsRm8vRzN5YWF3L2FteXFqbS9DTXZtbnorWkRRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4615.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SnFuRjBxaTFkbWpMRkVsRWlNS0NCVU1QNFhkQXNMNld1WW5JTXFuUmRlaXNK?=
 =?utf-8?B?T1RnNlNDVXdLN0RFNnYrVzR6NlV1eGdVeGdqcEc3eForR21hYkZDWWQwWDk3?=
 =?utf-8?B?bkNCblBDYzdVVUVua2xpajN1UXRvSitEZERNMWxWWGE5R25US2lnUXI2cWFr?=
 =?utf-8?B?c3ZHa2ZPdlFCKzNDWnZ6MWgzNTk0SENGWTFKQWY0VWszZFkzLzcvWG1Ib29x?=
 =?utf-8?B?c291Q2V2WHpCeXlyeEVlZ2ViZUJBeXNZaW5ZYkh2ZFN4RVpnbHdHU1dpTlU3?=
 =?utf-8?B?ZElBT28wTi9IL3RTcHRFekRVQTB1dk5VbCtZWjQyM0hCR1IvYXNXWklZaXpx?=
 =?utf-8?B?Q0FOUXlaalE0MG53MkFxNHNGdVF5REdXVnAwWEhSWlZabEZwLzdNV3ZaT2hG?=
 =?utf-8?B?WVVRMnVVcUdkVk9uRFJuU0RVaWNRWWQ0QzVyYkVZUmRKdzljSWhmdWhYb0ky?=
 =?utf-8?B?ZmJIU1RTK0J6Z21ONkdNZncyTi80alp3emxCVjNzYk9sZFhycnl3NFdtV2hC?=
 =?utf-8?B?OVRFOEhXcmhZcmduR2RXazhicmJEUWg4L0FMbmtGUXFETFJuMEEvMUZpc1ZR?=
 =?utf-8?B?SzlGeURoK1ZiSXpoVG40c0syRGo5TmtiTzF4dENDemZSNTB3d2ZzYlJrYm5M?=
 =?utf-8?B?dHRlTmZIQWlQbXIxdGsxSi9wWVUzbUpZTjI3YSt6N2VWMTMzaTBQVXhNOVQv?=
 =?utf-8?B?b2w3MVJZNnNuZVlnZXZCSnZvaEgyY25ZbWxVbnZZeUxkOWwrTGlVK1ArWTdG?=
 =?utf-8?B?NHFRRzBCdVo4T3hZMVltNGZyL3grRTRETjVnWG1TZXdPT3FDbXhqUTVORVdN?=
 =?utf-8?B?eDViRTdrSlVZY1pCWXdWZXFUY1JlVUhwOEcvbzVqdC9iTjkyYlc1YTFtZW1Z?=
 =?utf-8?B?Wk9PVDhaaXFpK3NRazlXdEhtelE3dXlXZEdPTzJ4cloxS0M0TzZhQ0NJZm1J?=
 =?utf-8?B?aktUMWY1bkJubjdqblpxRXJSc0ZxZWx1SlkwVFkvVUg4Wm5FaFo1RXRyUk45?=
 =?utf-8?B?Ky9BRWZYTzdFWXgxZ3REK3dNckYwZldrVGo2Yi8xQkVqT3gxZXVGZ0JVOWRu?=
 =?utf-8?B?QXphV2xYVjk3Q3g1czhmZkVLSGpUamIwQm8veHlBaWZxQkhsSFVidkUwZkcr?=
 =?utf-8?B?dXZqRisvR2xwditQUmMwb0tEYmFDRUxCZWlyOVpjSHI5R3l3WTdlNjJreXJq?=
 =?utf-8?B?VXZiQVQ4MldJY3p1Y1hXNVRUVEc0bHdvQWQ2RE93RS82d1QyZHRmRVZJelZG?=
 =?utf-8?B?ZnJ2bjBNN3V1VG5UV1ZFNmJaN0dtVkFUKzExTjg5ckFTYUt4aCt5azFaR1Zi?=
 =?utf-8?B?aVV1bmhKbjdEL2hBejE0RmJwSHVJNC9OSFRyUnpHUHhCbHRNQVJvUVdoQXFx?=
 =?utf-8?B?UFJwWXY0anRJQXlaZGk0NkxEOGprNVd4Y0RyVHJMT3VCR2xydTlEcDJ6MXpW?=
 =?utf-8?B?ZTgwcXpqeHB0R01WV0RjRG52TTE5VEd0c0ZxWm44OGMrWmZnY3ppai91Zkhs?=
 =?utf-8?B?R3hBTEQ3eW8zL081bHBPRWc3c2EvSUNlWHJtaWlUaGlvU0ZIa3NFYnREbzM3?=
 =?utf-8?B?NjZmVjFUOFRlRDUrRW8xYS93N2FSWm9IU0FVM240NS9RUGxHanhMVWk2a2hy?=
 =?utf-8?B?S1MrTk9HMmVDTzl4eTFmTUVyMmdPQWdSNUNJYUtNSk0vVHVERmNlOUFkOW5T?=
 =?utf-8?B?ZDFjK1lrYjlweFgzQkVac1JOYXRvUVlRNjJzMjltdUp2ZkJHbS8xTlltS25D?=
 =?utf-8?B?K2tPUEdmY2JQMHhicnpSanZCaDBrSG02UWVXeHBEcHplY3BmcVhJVDFtZ3Z3?=
 =?utf-8?B?UzdqM1gyMGNXY1RPTEcxUnI0Q293NGY0STg4YmV5VjBNMW05d0dhcEtVamZa?=
 =?utf-8?B?RzJleU9vT1ZCVEhtVUk1aHFuQnNPYlRzd1dJZXlKVFV5aFdtL1pPUlpmL1A2?=
 =?utf-8?B?UzhXZDNvcEszMnZrVnJRNzV3L08yVXIwVDkxWE5FSWFNMkh2eU1NQ0FuM0lz?=
 =?utf-8?B?VnNBbmU1ZEp1cExwZ0VqRjY3ODk3aWdqbStGdkluQzhOT3IwLzFaQ0FabUFk?=
 =?utf-8?B?M1ZoUldsbU1WTVBKeSszaHZTdlAxV09VNVBXdGp4VnR6bklGSnB2Y1pEUkpt?=
 =?utf-8?B?cytvRktRVmlwVFRyN0d0L3c3dkR2UCtzcVV3Zm5GWEVlYVJFdlRrUWNxbkFB?=
 =?utf-8?Q?WiEV7Hb0aV3LExLLxtNM31c=3D?=
Content-ID: <685DAAB4C427414D804559240FC9FC31@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4615.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ae3d9d-cb8d-4872-988a-08dc712670ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 19:21:49.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyE5NGQi9hArfETrioQXYbGypOzXXri/uW4rkb2fXpSvyd8ybxzZeRAeS8oaMqbhSEcdsdfafOTHNq4E/ugFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5843
X-Proofpoint-GUID: q07WLrgTLkqdV-4ymLJYOur0a4tT4p3D
X-Proofpoint-ORIG-GUID: q07WLrgTLkqdV-4ymLJYOur0a4tT4p3D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02

DQoNCu+7v09uIDUvMTAvMjQsIDc6MDYgQU0sICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhbGV4ZWku
c3Rhcm92b2l0b3ZAZ21haWwuY29tIDxtYWlsdG86YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNv
bT4+IHdyb3RlOg0KDQoNCiEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0
ZXJuYWwgU2VuZGVyDQoNCg0KfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQoNCg0KT24gVGh1LCBNYXkgOSwgMjAyNCBh
dCAxMTozMSBBTSBNYXR0aGlldSBCYWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZyA8bWFpbHRvOm1h
dHR0YmVAa2VybmVsLm9yZz4+IHdyb3RlOg0KPg0KPiBIZWxsbywNCj4NCj4gT24gMDkvMDUvMjAy
NCAxNzo0OSwgTWF0dGhpZXUgQmFlcnRzIChOR0kwKSB3cm90ZToNCj4gPiBGcm9tOiBHZWxpYW5n
IFRhbmcgPHRhbmdnZWxpYW5nQGt5bGlub3MuY24gPG1haWx0bzp0YW5nZ2VsaWFuZ0BreWxpbm9z
LmNuPj4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIHN1YnRlc3QgbmFtZWQgdGVzdF9zdWJm
bG93IHRvIGxvYWQgYW5kIHZlcmlmeSB0aGUgbmV3bHkNCj4gPiBhZGRlZCBtcHRjcCBzdWJmbG93
IGV4YW1wbGUgaW4gdGVzdF9tcHRjcC4gQWRkIGEgaGVscGVyIGVuZHBvaW50X2luaXQoKQ0KPiA+
IHRvIGFkZCBhIG5ldyBzdWJmbG93IGVuZHBvaW50LiBBZGQgYW5vdGhlciBoZWxwZXIgc3Nfc2Vh
cmNoKCkgdG8gdmVyaWZ5IHRoZQ0KPiA+IGZ3bWFyayBhbmQgY29uZ2VzdGlvbiB2YWx1ZXMgc2V0
IGJ5IG1wdGNwX3N1YmZsb3cgcHJvZyB1c2luZyBzZXRzb2Nrb3B0cy4NCj4gPg0KPiA+IENsb3Nl
czogaHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvaXNzdWVz
Lzc2IDxodHRwczovL2dpdGh1Yi5jb20vbXVsdGlwYXRoLXRjcC9tcHRjcF9uZXQtbmV4dC9pc3N1
ZXMvNzY+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2VsaWFuZyBUYW5nIDx0YW5nZ2VsaWFuZ0BreWxp
bm9zLmNuIDxtYWlsdG86dGFuZ2dlbGlhbmdAa3lsaW5vcy5jbj4+DQo+ID4gUmV2aWV3ZWQtYnk6
IE1hdCBNYXJ0aW5lYXUgPG1hcnRpbmVhdUBrZXJuZWwub3JnIDxtYWlsdG86bWFydGluZWF1QGtl
cm5lbC5vcmc+Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWV1IEJhZXJ0cyAoTkdJMCkgPG1h
dHR0YmVAa2VybmVsLm9yZyA8bWFpbHRvOm1hdHR0YmVAa2VybmVsLm9yZz4+DQo+ID4gLS0tDQo+
ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvbXB0Y3AuYyB8IDEwOSAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDEwOSBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Byb2dfdGVzdHMvbXB0Y3AuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rl
c3RzL21wdGNwLmMNCj4gPiBpbmRleCAyNzRkMmUwMzNlMzkuLjYwMzliMGZmMzgwMSAxMDA2NDQN
Cj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9tcHRjcC5j
DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvbXB0Y3Au
Yw0KPg0KPiAoLi4uKQ0KPg0KPiA+IEBAIC0zNDAsMTAgKzM0NCwxMTUgQEAgc3RhdGljIHZvaWQg
dGVzdF9tcHRjcGlmeSh2b2lkKQ0KPiA+IGNsb3NlKGNncm91cF9mZCk7DQo+ID4gfQ0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgZW5kcG9pbnRfaW5pdChjaGFyICpmbGFncykNCj4gPiArew0KPiA+ICsg
U1lTKGZhaWwsICJpcCAtbmV0ICVzIGxpbmsgYWRkIHZldGgxIHR5cGUgdmV0aCBwZWVyIG5hbWUg
dmV0aDIiLCBOU19URVNUKTsNCj4gPiArIFNZUyhmYWlsLCAiaXAgLW5ldCAlcyBhZGRyIGFkZCAl
cy8yNCBkZXYgdmV0aDEiLCBOU19URVNULCBBRERSXzEpOw0KPiA+ICsgU1lTKGZhaWwsICJpcCAt
bmV0ICVzIGxpbmsgc2V0IGRldiB2ZXRoMSB1cCIsIE5TX1RFU1QpOw0KPiA+ICsgU1lTKGZhaWws
ICJpcCAtbmV0ICVzIGFkZHIgYWRkICVzLzI0IGRldiB2ZXRoMiIsIE5TX1RFU1QsIEFERFJfMik7
DQo+ID4gKyBTWVMoZmFpbCwgImlwIC1uZXQgJXMgbGluayBzZXQgZGV2IHZldGgyIHVwIiwgTlNf
VEVTVCk7DQo+ID4gKyBTWVMoZmFpbCwgImlwIC1uZXQgJXMgbXB0Y3AgZW5kcG9pbnQgYWRkICVz
ICVzIiwgTlNfVEVTVCwgQUREUl8yLCBmbGFncyk7DQo+DQo+IEkganVzdCBub3RpY2VkIHRoYXQg
dGhpcyBjb21tYW5kIGlzIGZhaWxpbmcgb24gdGhlIEJQRiBDSToNCj4NCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvOTAyMDAyMDMxNT9wcj03MDA5
IDxodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy85MDIw
MDIwMzE1P3ByPTcwMDk+DQo+DQo+IElzIGl0IHBvc3NpYmxlIHRoYXQgYW4gb2xkIHZlcnNpb24g
b2YgSVBSb3V0ZTIgaXMgaW5zdGFsbGVkPw0KPiAnaXAgbXB0Y3AnIGlzIHN1cHBvcnRlZCBzaW5j
ZSB2NS44LjAgKGZyb20gMjAyMCkuDQo+DQo+IEl0IGxvb2tzIGxpa2UgVWJ1bnR1IEZvY2FsIDIw
LjA0IGlzIGJlaW5nIHVzZWQsIHdoaWNoIGhhcyB0aGUgdjUuNS4wLiBEbw0KPiB3ZSB0aGVuIG5l
ZWQgdG8gZmluZCBhbm90aGVyIHdheSB0byBzZXQgdGhlIE1QVENQIGVuZHBvaW50cz8NCg0KDQoN
Cg0KTWFudSwgYW55IGlkZWE/DQoNCi8vIHJldHJ5aW5nIHBsYWluIHRleHQgZm9ybWF0Li4uLiBw
bGVhc2Ugb3V0bG9vaywgcGxlYXNlLCBtYWtlIHRoaXMgaGFwcGVuIQ0KDQpJbmRlZWQsIHRoaXMg
aXMgcnVubmluZyBVYnVudHUgMjAuMDQuIEkgYW0gcGxhbm5pbmcgdG8gZXZlbnR1YWxseSB1cGRh
dGUgdG8gMjIuMDQgKHdoaWNoIGhhcyBpcHJvdXRlIDUuMTUpLA0KQnV0IEkgZG9u4oCZdCBoYXZl
IGEgZ29vZCBFVEEgdG8gZ2l2ZSBvdGhlciB0aGFuIHRoaXMgaXMgbm90IGdvaW5nIHRvIGJlIGlu
IHRoZSBjb21pbmcgbW9udGguDQoNCkl0IGRvZXMgbm90IHNlZW0gdGhhdCBpcHJvdXRlIHByb3Zp
ZGVzIGFuIGVhc3kgd2F5IHRvIGNoZWNrIGl0cyB2ZXJzaW9uLCBhbmQgdGhlIHZlcnNpb24gcmV0
dXJuZWQgYnkgdGhlIGNvbnRhaW5lciBpczoNCiANCnJvb3RAMDgxYTAyZTU3MTc1Oi9hY3Rpb25z
LXJ1bm5lciMgaXAgLS1qc29uIC1WDQppcCB1dGlsaXR5LCBpcHJvdXRlMi1zczIwMDEyNw0Kcm9v
dEAwODFhMDJlNTcxNzU6L2FjdGlvbnMtcnVubmVyIyBkcGtnIC1sIGlwcm91dGUyDQpEZXNpcmVk
PVVua25vd24vSW5zdGFsbC9SZW1vdmUvUHVyZ2UvSG9sZA0KfCBTdGF0dXM9Tm90L0luc3QvQ29u
Zi1maWxlcy9VbnBhY2tlZC9oYWxGLWNvbmYvSGFsZi1pbnN0L3RyaWctYVdhaXQvVHJpZy1wZW5k
DQp8LyBFcnI/PShub25lKS9SZWluc3QtcmVxdWlyZWQgKFN0YXR1cyxFcnI6IHVwcGVyY2FzZT1i
YWQpDQp8fC8gTmFtZSAgICAgICAgICAgVmVyc2lvbiAgICAgICAgQXJjaGl0ZWN0dXJlIERlc2Ny
aXB0aW9uDQorKystPT09PT09PT09PT09PT0tPT09PT09PT09PT09PT0tPT09PT09PT09PT09LT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KaWkgIGlwcm91dGUyICAgICAgIDUu
NS4wLTF1YnVudHUxIGFtZDY0ICAgICAgICBuZXR3b3JraW5nIGFuZCB0cmFmZmljIGNvbnRyb2wg
dG9vbHMNCiANCiANCkhvdyBjb21wbGljYXRlZCBpcyBpdCB0byBzZXQgTVBUQ1AgZGlyZWN0bHkg
dXNpbmcgbmV0bGluayBmb2xsb3dpbmcgaHR0cHM6Ly9naXRodWIuY29tL2lwcm91dGUyL2lwcm91
dGUyL2Jsb2IvMzk3MzgzYTMwYzNiMGUzZmY1NTEwNDJiNjY1NDg5OGEwODcyYjgzZS9pcC9pcG1w
dGNwLmMjTDU3MyA/DQpTZWVtcyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvbmV0bGlua19o
ZWxwZXJzLmMgY291bGQgYmUgdXNlZnVsIHRvIGRlYWwgd2l0aCB0aGUgbmV0bGluayBwYXJ0LiBB
bmQgdGhlIGZvcm1lciBsaW5rIHRvIGZpbmQgb3V0IGhvdyB0byBmb3JtYXQgdGhlIG1lc3NhZ2U/
DQogDQpNYW51DQoNCg0KDQo=

