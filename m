Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBE6F5DE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECS1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjECS1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 14:27:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1644237;
        Wed,  3 May 2023 11:27:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hp5lp001674;
        Wed, 3 May 2023 18:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hupVi/315AEt/9U5lj40ld+T3yxIVAEOch6O2Ih/Srk=;
 b=FybX1qrzfNTz+I4+0ygD5qtmmh1VUmcCoZxR6Srm2CjVzB+aKWDOT0cr8P5gtJhNr4kW
 MEgqJN/nTFJscG7ZGhjLRVS74k6DvikI4zB+4VEoDhYuynj0zjN+Df+W7zOhrHanzfsK
 EsNQ1xiaDoJfdhBupysJgNJ83g89kXVFt6UNI8j4H8tbRcyYR9C/eeP0sICpxLmGc1db
 7T772NVRuCqo30ZtvRFQNXcn/UZnuQLaNJUvIQB3UkXsi+2vqAqElKsNEjP4DkHuALl1
 susHZP4+d8xNOIUcM3plAjJ4x0ztQawZ9rKMvTN2QruIs63C1D8eiQcRdLMiZrZ/pr9i Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv00eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:27:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HSqXD027652;
        Wed, 3 May 2023 18:27:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spds2t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPOjWAiONzy7mGEw6Hm586F2mOqJH+bJFF9P6HKHDzXczM/rQrL7BaW22d5pK4fYIsPzLFmEtkByAjpnzYeR5vveDwucjVaCgnhcg7+tnxBtCwGH12HeV+hvhOVIkX7nPorFAh6U7VzPhwzaFlL5QzP9fbp+iNTUK9d3hBDyidK0PQ9y696cCZX11gj7GCZOXKoixXIoEty1o6aGEJwVQFTln1ewcUmFBJfSrfRMyuxa5pz9Mx7U2J1HgJFhqz4m3cc7Mbt30zxDkt1Rh3TGDVL6B4QH41l2+7A3w13EpMhmHQ6J2CZFY7fhkdWku+CrNzR/5pNRR7+dL+XvLpjeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hupVi/315AEt/9U5lj40ld+T3yxIVAEOch6O2Ih/Srk=;
 b=hYVxKdnP+Crtbt2N075mf6NVUuDhql3uUwO5Fmu11zKLX/Jb8za7pPwTRNmpfLdHeGiuBRQFkqwZvxvYkPMWwyqd/sbdWrPNz/LiJZDC+ZOpDJlwm8W8ZmcWys9rCOzzcgiWjblexNi2LXFrt8rUPWoNdKoq4FAoX+KVPtofzkzplcXXNIIg3H7ZXLNKzR6YqHX/5tpQSfaMwMDW1iTT0p6Re0qyjcexTKza1zDWwnYF9bh0M2PAD1yjsDERyb2U2bC7uM2WgK7IjsUtMMIz20vLE//E9bVOVRhOqL8yYM+dtHbOVhk3v+ES1JDDwxDyrFoQNjl1C4Xvo/XPGHm3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hupVi/315AEt/9U5lj40ld+T3yxIVAEOch6O2Ih/Srk=;
 b=B9sKcE7CpvCdsbuuMmSKCnTm884KYCaE89pwcg4pDiXVkuKMfv/j6Q9PTcWHrVGVtWQhi1kwRY5KWQ+zdUfBRo725210sSIR8qmB+7x5CEiQXotqyQ0wHCj1QB+F+bBbbVoabcamsYIV7PQZQcnqScmrVpDiEiO486OHacQPjk8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB4992.namprd10.prod.outlook.com (2603:10b6:5:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:27:10 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516%6]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:27:10 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
In-Reply-To: <CAEf4BzbOCHkBJq5OFNtwcbFWVjZBosECiYx_dLgnNYTX_MdAaA@mail.gmail.com>
        (Andrii Nakryiko's message of "Fri, 28 Apr 2023 10:20:15 -0700")
References: <20230406004018.1439952-1-drosen@google.com>
        <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
        <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
        <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
        <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
        <CAEf4BzatBnBH8RHczLerMsW4NvTtx6xj5COjGzVvTkRxfciw4Q@mail.gmail.com>
        <874jp0bcoy.fsf@oracle.com>
        <CAEf4BzbOCHkBJq5OFNtwcbFWVjZBosECiYx_dLgnNYTX_MdAaA@mail.gmail.com>
Date:   Wed, 03 May 2023 20:27:03 +0200
Message-ID: <87bkj1p8y0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 652b9ad4-a3ef-4652-9fa8-08db4c0401ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAqO+BUiU5QMMTj19jbN0QkvurVyCqL50Ybd68e+HKr2nj9/8cSrDx2Md8hTSy9q14hEVD7UhyJWJvnKXsCOImNBK+YdcHG9PpYnBSCbxRi0bJdG+0evixiRadkYQvXvt2YzrpanH9P9a0EZoC286ey9F+6J2gtfO2nDpwvy+WfVQ2dBauSDgykwBda17YUZRpviPqFdMUE2kFMu4V7cx1ugDQSyV4uMyv7+UOsN7Pf4sJb+GM+Wxh8P8zJ8Yc/7vDaWeFu1AAr0za2W16xixe6BTlRjC3cRTaEPE7Pw5P+807LU5sU4HfbWPvV6URl/8o0Ks59M5ESSThV/zhvThSalS4GNVKF5c4pTb45efYuReh+faAmSWJDn9aMdhEnJ8gaD/ZlgAxOnxdH3GXHU5VLhA+mSiHReIdiVal2kLmV3N5ocdr2d+BB6HeuPa+88CZL7vdsqHKr7RQrr2yw0QenbrzxpHbE450nAht8Kw3j9BP+N0/FaFeVkdM40aYuTZQMAo7HqJ69e+01KuxP5DXEPDrW7IXCplyuqVwB2oOjsHLnHlG/87jhS0Wl67apN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(86362001)(2616005)(6486002)(186003)(83380400001)(2906002)(26005)(54906003)(53546011)(6506007)(6512007)(5660300002)(7416002)(66556008)(66476007)(38100700002)(6916009)(4326008)(8936002)(8676002)(66946007)(478600001)(6666004)(36756003)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3kwMWo0NkFzVk1FOHJZckw3dFRrdktFdFBIWW82bVh4eDFaU28xZXhFTE9D?=
 =?utf-8?B?QTY0dlZjWW12Nk15QkZVcFUrSzVhWmw0TnlzTmpoQWRTQ3FGdGpJREZKaUtx?=
 =?utf-8?B?UW1jMTZBVkJ5YmJISUFudGFYdHpTdlptYjNIbWhtcUZLeHc0Ym5JMlUrVmJ0?=
 =?utf-8?B?NDRmWkVodDFIK2RLNkNGTEN1a0srSnlEakRxbG4rNUpCaXJEOXhObDNuU1FS?=
 =?utf-8?B?Znc1MzlvaHUzb3F2SkM1bGFBUW9ZR0szTVJJYVdwQVFpS29zQ2V2bkZPZlNu?=
 =?utf-8?B?M0ZDeEcyMWpjUlNZUkc0SVVrSFVMTVl6L1dta0ltVXV0bG1YYnVWWWxCQmVh?=
 =?utf-8?B?aHhQYUl4SU9OWkhDNHZ4R2JmcmpaZ3BuNytlS0hycW1KS1hCU09wRW83UE92?=
 =?utf-8?B?V1FGZTdielJ1eFNmYnFyQXBhaTJJVWw4M1VrQVIyYktZNkhqRjQwb0JHV1g1?=
 =?utf-8?B?a0JQOENYM1JRdENSY3hYSkpUWVFsbnV4c0I4M0dPTFdUdnFRTkpRZTAvWGYx?=
 =?utf-8?B?RjJZVjJMTi96RE5uVFlwZVF2YmRrT00zVytuenM0di9Za1lIdzNIa2lyZ0ZP?=
 =?utf-8?B?RDF5aCtTeXl3MVdMbWRDaUoxZktibFFFREJraWtSNnNNUjRKQlB2WXNOUUVj?=
 =?utf-8?B?THVCeEVMOThOVlNyNHhvV094bTUvdkxGRzBTMnlFc29ybTVOWjY3Y2dIOGhp?=
 =?utf-8?B?ek0zVWd1NDExWWJIOERiakp3UGcrd1UzQ1JYZUsxTERUb2VDbVBVcWFDUUNY?=
 =?utf-8?B?SEt3OWszSkU4RUlTamtZUHRrK21HMWhVOGR3bkpQSzVheWxReHJETzVwRzNX?=
 =?utf-8?B?NHlmbVlVd25RU3AxWEhmOHJvYWJXSTZmaDVxYnBncjVXRW85N2RjN2xPMEVY?=
 =?utf-8?B?QmlURkViNW5sVWFUTWZVRWVqT3lLaGdjOHRINHE5OWROVVpKR1ZRZHlvMTFF?=
 =?utf-8?B?QjhDRkNBeWFiL0RxWTFMeGkvOGlpRU9ZbXEwV1lkK3QzMmE5VzYrVDA2bjE0?=
 =?utf-8?B?M3dtMnloZk9sU3VCOUtrVTF3WjlDNTFmaDJ1VzBnSDBxT29CejRzLzlRclor?=
 =?utf-8?B?MWlMUGpoZHNxYWI5MkhSUFBSM3hKbkJ6M3lQRmtzMVNkSWU5WFNuU3N6SFJ2?=
 =?utf-8?B?eEtxSWd6elIvc01JV3VLVHl3MzArcVlxVkpsREhJeXZycE1zUTloWTVKNy83?=
 =?utf-8?B?RFNUT0NVWEFEMWpGaWVIbXFqeU13UmY1cEl1aHc5eVJ5Zmh3dGExV0ZRL0JX?=
 =?utf-8?B?UEsyaHdzS2IwdFo5ajlqNEhmYS9YQ3pyNXFJWno5bWZ3WFE2Uk82bG11TGtM?=
 =?utf-8?B?NWYvalQ1YkJqSFFNWFZnQmpLRVlRa0xjMWZJNk5WS3RmNDY4VXVNQWFyNU50?=
 =?utf-8?B?cktHQlMydDB0d1FTbWpjOURkaE9ZN2tVZXQ5VFBXY2dIMzBLZmNDTDM1TWlP?=
 =?utf-8?B?Zyt1OHU3aXJXdlN0a0ZmREZSWFd5WVlZbG1QUWUrZTE3REt0bWRKZXBadjVO?=
 =?utf-8?B?RHFUUkljdGZrQ2JEUGs3Unl1dnlPUVNoaU4xMzQrUG9DSmdHbkNYT3RZLzNU?=
 =?utf-8?B?TGhxY0xwMWdieENucStEOUFvNVhUU0VGMjF0MW41Q2pWM1pTRjdNZHo1emwv?=
 =?utf-8?B?TUhsNUtodGpqdXRic1RJRUVnQ1Q1ZmpEVmtVU3oweUJIUFpUTGZYT3VzdnZN?=
 =?utf-8?B?Nmp5djEwOW9JelEzN3lrNmgzeElCdU9LMGFGYVJFSmxhWTNNWm5JRExtN3l1?=
 =?utf-8?B?MXhZYk5mdVZGNll4dlE3TVFCT2dra3BuMUplR0VnR0xwZ1ZFcElvT2RYWWdN?=
 =?utf-8?B?S3JVR3BRZjV2NTNvUnloWXJjb1ovN240eVJad2JtRThhOUhTZUNrNDJMZS8r?=
 =?utf-8?B?MEpTY1ZtRnlnODlQSWdaQnhXazFGREpFTWQxUTF5Vm5QQlhzLzk1UXh6TGpJ?=
 =?utf-8?B?THBRWE11UzlMQkZVWGE0dzJYZUJsSzJDb0R0eFlZaGJJejVxa1h6VDhwWlp5?=
 =?utf-8?B?UlBDNkpERk5WVUsyZDZNem10bUIwWlE4ekdGU05GTTg4QjdEZWk0V3cyM3Ez?=
 =?utf-8?B?TXF0MHJEd1FhOEJrdS91ZzBCNWtKUWliT1ZJOUJpdThZM2VvclR0MzRNTW9I?=
 =?utf-8?B?ZDlhQjB3R24vWTAwdjFJbnV1S3dCdGp4Sm9ITlQzWDB0eDJKbFVFekhLUFRh?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WGdGSGtFbFFDMjBGOXRqVXdBa1lVNXBONmtzRmM3RnBDR2V6czgzS0NsVG5M?=
 =?utf-8?B?dEkzMjRWb0h4bXh6S1ZWUVlHRU5rTGJMTXBZdWJ0TFliY3J4Q21IK3U2Tjh2?=
 =?utf-8?B?Ti9FN0JSQVpNUU1lSnRCSkxGSVRwZHdqUDZIbjBVT3F3YWJiVGV4SWV4a0Nr?=
 =?utf-8?B?dHVCVENsa3RoZGpsSnJsM0NNcjBKTXZCUThxdnJzMWFNdWo1RXdtbEtnL2Z6?=
 =?utf-8?B?amxOaUxNU3J0YWtwQ0lJQTU3ZENsVHArd1BHMkVHUHZ3alF6bDlTZ0hYOWsw?=
 =?utf-8?B?RWJWbkl2Tk1mMlRtN05vZW9ZaE1pNkFYbFdENXI1bDIxbDF3bWd3SnNjRVZy?=
 =?utf-8?B?MEdBWjQrNDBBTzBoR3ZSVnl1Rit3cGJiU2FPM2JYcXllYmE5MXB3dEpZNkZr?=
 =?utf-8?B?T0tzbVBOUjV6S0JFWnh4Nnh6YWVITUpOSDkzZ0NKQ2JiL082b1RqQkhDUFht?=
 =?utf-8?B?L1pySE8vMHFHbWZMUjdkTFA5MlpUOE5JeCtRcnU0Z1g1TExwRDFqLzMrcW5x?=
 =?utf-8?B?ZFhXSFloaDN2d0hST3NKZ20rK2lPYTloRDR4TGloVzN1ZTluYWpUbGhZY3Rk?=
 =?utf-8?B?TXB2UDM0LzN5VVYzOExNc3JJbjlpOHlabnhBVWpOSWJ0bUhWODNVN3Z0a3pJ?=
 =?utf-8?B?czFhRm5pMkV6TmhBUXBqcGtXNENlRlF6TWNWV0VWNGl0Qkcrd0ROTFV2b1Rt?=
 =?utf-8?B?Q2NZK29jL2F6NytteS9VUEphMmU1V21PUzNuOCs1aXkzNGFDYWUveXVFN0lt?=
 =?utf-8?B?ektoTmJ6bFk0WEpINDd1S1ZuVFVPdm9EME9YUmpqMElNVEVNZUV4d2xScE9h?=
 =?utf-8?B?TkppQWNHQS9TQUJ0Z01nbTlKTS9QWjNMTXc2ais0djNsejJ2cDUyTVpmTUxY?=
 =?utf-8?B?Q0paam96RUNHYjl0ZTdEeWhFdXBPUEFuY24raXJzb1dYSmRvVE85MmhDTHlK?=
 =?utf-8?B?RlE4VzdOUFQ3M2tJNFEycWpsV2Zjc2pZMURMZEgvd3Y5UUp6c0ZFK0ZwaVN4?=
 =?utf-8?B?aWx0UWtWN3diTDVOUkMzV0hacUVHNUNMMlcyRmo2ZXVmZjV6UWRjTkRWTHEy?=
 =?utf-8?B?ckYra0dQQ0NPSVZUcnRUNVRyQ2cvenNBQVFpUDloTXpnc08xUGx5K0p4UzQ0?=
 =?utf-8?B?d1FUaEEwcWw4cnFyQnBPTnZMemptYjJXdjhqVkFUSjM1TnRZQU5FZ0h3d0E1?=
 =?utf-8?B?Ly9sOHNDRGRmK3RpbnpFWHl2SUxGRkNnN3JVVENldWM0MXhPMkRLcVJoVjRp?=
 =?utf-8?B?SU1KOGxleVRiWi94R0FtZUUvZEtZZS9zWm85SnBkNUlLL2l2VklTT0NRald6?=
 =?utf-8?Q?SVj83CoLExE+8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652b9ad4-a3ef-4652-9fa8-08db4c0401ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:27:10.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPgf87Ge+we1BK6kPN1yw5JfM79Xc+yVXOfctgMexHvtXnyGllLyLBh7p0crFgpU1vUSv+f8ZBurPO+t9+so2ufyM4JXuJ/nKmXSK0z+WAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030158
X-Proofpoint-ORIG-GUID: QCU0ehDhetx4ngmH2Or5L_x6dcRB41XD
X-Proofpoint-GUID: QCU0ehDhetx4ngmH2Or5L_x6dcRB41XD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Fri, Apr 28, 2023 at 2:04=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Thu, Apr 27, 2023 at 4:36=E2=80=AFPM Daniel Rosenberg <drosen@googl=
e.com> wrote:
>> >>
>> >> On Wed, Apr 26, 2023 at 4:39=E2=80=AFPM Andrii Nakryiko
>> >> <andrii.nakryiko@gmail.com> wrote:
>> >> >
>> >> > Don't know, show the sequence of commands you are running?
>> >> >
>> >> > I have linux source in ~/linux, and KBUILD_OUTPUT set to
>> >> > ~/linux-build/default. And it only takes this:
>> >> >
>> >> > $ cd ~/linux
>> >> > $ make -j90 # build kernel
>> >> > $ cd tools/testing/selftests/bpf
>> >> > $ make -j90 # build selftests
>> >> >
>> >> > And that's it.
>> >>
>> >> I've tried the same, modulo some paths. I'm pretty sure it's version
>> >> related at this point.
>> >> The current issue I'm seeing is "error: indirect call in function,
>> >> which are not supported by eBPF" when using GCC-BPF for
>> >> progs/bind4_prog.c
>> >
>> > I don't think GCC-BPF is able to compile selftests properly just yet.
>> > So I guess the problem is that you do have some version of gcc-bpf in
>> > the system and selftest's Makefile tries to build gcc variants of
>> > test_progs? That's bad (I don't have GCC-BPF locally, and everyone
>> > else apparently as well).
>> >
>> > So for now just `make BPF_GCC=3D` ? CC'ing Jose, we should probably
>> > agree on some criteria of "GCC-BPF is really capable of building
>> > selftests" and adjust Makefile to only attempt GCC BPF build in that
>> > case.
>>
>> Being able to run the selftests is our goal at the moment, but we are
>> not there yet, no.
>>
>> What about making the kernel build system to emit a visible warning
>> before it builds the GCC variants of the tests programs?  Something like
>> "this is experimental and will likely fail".
>
> Given gcc-bpf can't build selftests right now, should we just disable
> it until there is a version on which gcc-bpf works? We can make it
> such that you can force it to build using gcc-bpf (make USE_GCC_BPF=3D1
> or something).

I think that makes sense.

>>
>> >>
>> >> Currently using clang 16.0.0 and gcc 12.2.0-14.
>> >> I did manage to get it to build by just commenting out TEST_GEN_PROGS
>> >> +=3D test_progs-bpf_gcc
