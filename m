Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01D1632996
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKUQeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 11:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKUQdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 11:33:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150AB2AC5;
        Mon, 21 Nov 2022 08:33:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGMkm6022936;
        Mon, 21 Nov 2022 16:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9omRGcpgE9cn1Pv66Qrgj6z6R8k5t9fw+rYomRFbsJ4=;
 b=wMB3j1Vo9pCLVpxtIHY2xsl/jb8ShB/RHook6gpwz9ipgD8PPgNpLZbEcfstArunTe1u
 F/H34e452o/xGUegFFWD97o1r/MIgbfM0XFaGfwTqVdhnSxwvtnPEKZzmcIREC8t/i1A
 PRX8jM6MBVUJ9R9iKh4ObxjT9UCYPCPBo/pZfgCQb6aWBbPa2YtF+aPEIl+4n1YZyUzH
 REplbou2BTK8f/6yOh5lmuiJmo/EPp+ng0cnc0LNl7S8gY/O/25/QiZJsZsUb75U6O8e
 ddMPldtxIXr9nL78yppDSTT6Y2i1KTSysfZgY5dtX+U10EmuV5O3FEMkGLBhcJmmWMmo MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0ct1g186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFctbY008204;
        Mon, 21 Nov 2022 16:33:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk3ex0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5cEP8jYJSi2vt3Pu5Ao35+ErwWdOsXqAaaHumIOM58qJ5ha0P4KvGhYYKyyL26iZF41bm5OthpMxovyVVbQTuhU1AM1KxXu87sVzr/nTAGdWgA3fhzTS34lpw4rVrIKQDMoN73JQcBqlmbI0aOtbyS3CQXFnWzQ3glD3VuS4FlhQhGYlvFjfI5w4NC8/YZgmvevHVGIAk8rpDPttpIa6QOqMn1FFVjqJA/fauRXOG4+EXX66gi+NXPNXlsogzPE90lR7217ZSDNwtyGmuwZPvq35IVA6RBl8yx7JVMI7LX2B416Cd5uwrv3zUm5e6X38pHwVkOqAN/q1s6ud8uR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9omRGcpgE9cn1Pv66Qrgj6z6R8k5t9fw+rYomRFbsJ4=;
 b=NB5HzTS/IRIWJ+9kqLyOUyzDf7dRhXjEjqtBrffhKotd7xSMrhEsvhtGtFm+kW7iVYHfe8nLy+ycmjcrhrxqGhSz6SQrj2ZfnPu+is9Vkaaq2j30yme6yzMi4Bl573UL2P+7KsKSOgdLRW+2k1IpAMZQf9EYvMHEXX8kjt+c8x7Ok1mh0cJ7B7duxNSMtx8QnLs04j8wCanWVOcRKWeJLNenh1+Z/hE4zYfDu7uzGPifvoEwLald8FKf7DyFzuqg+FUukKrE9hPRx8CcvBHUg4/aPeVi18TdD3OdpFtmWC8Cm2Ne1w0GVpx7AIw3sEcq/NZwjsMpBSbV4FM5Wm923Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9omRGcpgE9cn1Pv66Qrgj6z6R8k5t9fw+rYomRFbsJ4=;
 b=o/ASk0IndqBp4yTM4gUCyHWzenRVBYHOBCN8/Lp6wreRq3TYo9vUhtsn8bcxPjHW8RSJbIV2wh/W3rqkGntDo1drdvlg46enRmJYafHb/j3h6E96gqADrzOpjPz9b4yRgmTBAKXCrgb9sVT3i1w5AOogNeTXO22+cNGlkpE5zls=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:33:26 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:33:26 +0000
Message-ID: <1152a5da-a573-6071-f171-d41e623fcef0@oracle.com>
Date:   Mon, 21 Nov 2022 16:33:19 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
From:   Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v2 6/9] kvm: selftests: add svm nested shutdown test
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
 <20221103141351.50662-7-mlevitsk@redhat.com>
 <2dccbbaa2d9e9aa7895fc03488c503c544aa0399.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <2dccbbaa2d9e9aa7895fc03488c503c544aa0399.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a28e84-cf43-4dec-198d-08dacbde1d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBa9TX0WSjZ2TY6ZZ6HoPmdx7vKPhBch23uBjmULGRWW/3tSPcuuR931ZICb22DhwvA4R+QuyY05EmJfVZDBVYhvfngs4+qp9hvXrSK8W6eal94pw8L/pWCkQmbjOzFw1P/Jx+cZMPDeRHR62yqzsqG4/yjqwni4eaNqhk45n8YbbSm1IyI+4l77Gi1L5p3dPcRAkpvqOb4HJWq6W+MzH2zKLl4Ki0BOWz25Oud4WVL3Zl6mhJteGz47zezC5IncB/l1KhBKE36enypw0r4Wr0kavaJYsLsFeNCZcKHU1sRBEIO8nHyJz4BUsqkBSwcxGNRWNYwBqLP0F96rBr+J7As+j8Xd+vZ26IB6n+/xAtPJkpnzP1kJVz3/qTLPb4FYvD5PZVqfD8je2hk5MPZ77/KbbhxOUnwaMKo+r8yy9enajr8OzMx5IvDzknxLGfH0GqA5Z3zXDwCELH8+h07sKXmL05uSAgVFRnSvwZQ+iemL21cU3+3PVTUbLq90TIBRu5lPEAiNhazMMcgH4skf0va19y99PMpIjfmRjKZlZ1/eB+ygwOPTFx1EGqEpeVy8Wt6P3zeHbGkT/k4necBoubYF4bvGEj5pgreiE1GIldP80y73hI7s1uaj93GdcUWVBTXznahwXrYSUa/FAbhbPHVxwCCsjQcyJz7R+TySopIbvJhl2604ZPZg+BarIsZdDeG3OaJY7LuEvAIWO4miwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(31686004)(6506007)(2616005)(66946007)(66556008)(41300700001)(36756003)(31696002)(86362001)(54906003)(38100700002)(53546011)(4326008)(186003)(8936002)(7416002)(44832011)(66476007)(8676002)(5660300002)(26005)(6512007)(478600001)(316002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhVVGdVL1AvY2F4SGJoNnczbmVtc0cwSlpDNmE4R0VRemhaVlhUNWttTmhW?=
 =?utf-8?B?UjNzV09HMlBkdVdiMlJiZDNkb1R1TmQ0NjQ5VngyUk5UQ0c3MUJLd1Q1SXJS?=
 =?utf-8?B?dmtnMDBuVDhlNlNkb28vbFJIcWRtSU5USlo4RUQvQlZMTUNhWlBaQitLTDh3?=
 =?utf-8?B?N0EwVWxaTGdUWVJVZkpsRkk2TExkRmFoV1UrME9jRUxldHo3VHBHdjdGOGpw?=
 =?utf-8?B?MmtIOVdDWlI5dzh1Unl5Rlc2Wml4blU0aDB2QnNtdHd1MklkZW9CRTV5aFNR?=
 =?utf-8?B?cjJ3eWR6WHdxRVBBYkJOZ0ZJSUZJQkhCaGtWQnhyUjhPZ0NpRkQ1VEhzZ1VI?=
 =?utf-8?B?dVlpNDE3Um5FS2xvejRTc3N1MGxUZnFtL0RSdlJPZkdEWk5Bc1FJak9yd214?=
 =?utf-8?B?NS9NdzN5M3FrR1JQSmZzVG4ybVExbmZNTDZqWkY1M2dFaDU4dThFak5kYUNr?=
 =?utf-8?B?c1kvdXQyeUFGc2I5aDV2R2RmdlByVlV6VkwyTEQ2NzNlSmRmRkdVU2tOcWNI?=
 =?utf-8?B?dzhmNU41K2UxOWJuOUd3TFpieDl2MHM3ZWNmaDI4MWhXd3NocnB2L1pSUlc2?=
 =?utf-8?B?N082MjFZNUhKNTZCZ1hYKzJmQ0ZLTWZ6VSsvY2Q3MG1qcGxqOWhNUGh2a1hJ?=
 =?utf-8?B?RnEwdkxmYkR3UWQxNFYzTTd6dDRUZlNBOWZSb2g4UXIxdGllRjF2UEdqeGJo?=
 =?utf-8?B?UjZwcVI2VDZoTVRBQStLQU5LZk5GdTlWd25xMG1JWUtjVnZNQXNia25wVFJ5?=
 =?utf-8?B?WkJUdTZqSEtQNUJUd0djWnJNaFhtdnQzR0lKK0FlZnIzOENaZXBVUG9lamth?=
 =?utf-8?B?RWI4RW9HV0ZxL25oVDA2b29JK2VzdkMzZGtZL3Jld05xR2s3QUxLcFJHL0Y4?=
 =?utf-8?B?TWoycWM0cVFwd0FMMzRHeVVxV3hJdGl6TFRSQlJ3bStqeVJVVjNOZzd1SWxJ?=
 =?utf-8?B?U0N2RjlLTjBicmJxNkk4bjRuWDUxN3VsQS9nVXJ3R0EySFBOd0J5YnhrdWpK?=
 =?utf-8?B?ZFIzR1BOMUJuOXYxZDI3N0F1TzEvRHg4VGgvN29LRjEwUFgzdFlpZzRTZHVm?=
 =?utf-8?B?NktPR0RPOUVPTVRkZjZEOC9FQjZ2TndFQ3R4bm9pMWcra0RWeDhhS3I2aWY4?=
 =?utf-8?B?NXhVM2VkSVNJMjhPMGZkbWNteFdlUFVzdnhudXM5aGhmNmMwNW5Na3NhbTlp?=
 =?utf-8?B?L0VibVdSWmV6eWFJbTl4ZnlvY2NTUzIzd0wvd3dUdTU1VTNTTjFaUm9Cb3R6?=
 =?utf-8?B?UTZnUFpPb204Tk1NS05DV1krSmEzbHRjVzNKZUxMajhXY3Z1Z1hpd3ZaNERo?=
 =?utf-8?B?a0pWdDYyTFFqdmsxQmRMcGpPVGE1cVhGTit3YkdJaVM4VHFsb1RWbGRsa09I?=
 =?utf-8?B?aVZ3STV0OGVPcjF4S0xJdkNtbGlETTJtSDEvNkp0L29SVjFmREcrSDRDVis0?=
 =?utf-8?B?cHdaV0N0bmdHTjA2WjBNNFVlcVVvb0NlTzhvUnpCNjBjdUFPby9lcnJPOUx4?=
 =?utf-8?B?TGl2WnNaVUJpMjVSQlJ6Kzc5ZTVyVG5RZkRVZjdyRmZ0VGJHZFFtREZwK3FV?=
 =?utf-8?B?dm5KZTBQTm5Makd4bTltNEdSSXdPUTlpQktFdHJKeHA2OUxNaWRqRlpkd0xM?=
 =?utf-8?B?bys4ditJSHZhS0ttU0hxOTlIZllCbEZlWTh0bElyTkZsV0h1SGdvL0xReFpj?=
 =?utf-8?B?Y3NvbGVnb2x2clE0c2dGeHlpM043UGltVmt6RklkRnZaZk5mbXI4YktXZ2sr?=
 =?utf-8?B?TldWbDNkT1pOTWUvL3NtWElhdThnYzFFVW1tK21WZjdNZzVpU2g3MVJsQUlx?=
 =?utf-8?B?S3hUUjlGWlpJYTNnQ2V5QlhhSzgrN05vdm0wWkVFZ3FhZzQ3NUJ4dUx1cGdt?=
 =?utf-8?B?MmtPVVVOUThCOFJ0ampkdkFvWm00cGplZzZBSytKakdhMzV0bEhERmhmb2Ez?=
 =?utf-8?B?aFZvaWQwWVJZQVlxMnQ4NXZpS3JNdk5Nb1dUc1NhUjlrZERVZkVWOWpRUGJv?=
 =?utf-8?B?NmdTMVVKQlIrMUV3UXdvMmhEYjlsbmplNktseVcreFAxZTF0UkNTUkY5WWMr?=
 =?utf-8?B?OFllVnlwNzRNY2prd3AvKzg2MTNLb0ZpcHlaVnBIVU5JbVlKaW85UjRONS82?=
 =?utf-8?Q?ykTMUlVZSYHEcIO5jIcuAw6K7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?azhBNDJ4STNacHMzbTA3NU5ZWWFjMzJqNDBNb2I3SGJoeWd0L0hNcjJmdjhM?=
 =?utf-8?B?WURQaHY3NmF0YWcrb21GN0dKV1RycDVhUjhsM0RiU0ZZZks4anYrQzFYVWlC?=
 =?utf-8?B?bTlZTHd2eDBTaFRwK0RTTnR5ZEhOOWJrbFRGNUQ4eFQ1bmEvcy9vVk5BVEVz?=
 =?utf-8?B?cnozWmJXejQ4QzdhQkJsTUxyamFwUTVxdEcvVkNTOVgvZis4K01JbU90UWJ2?=
 =?utf-8?B?S3o4NWRWbGtMTHlhNkxpRGNqK1lFaUhZK2tjZ1k1anlYRDRIS1NBSlZTdEZS?=
 =?utf-8?B?d0J3eVNaRVBxQ21rc213S2lTQkU3bzdoUU0rQlc2YkFqR1lJNHNpTmg2Z2Fq?=
 =?utf-8?B?TUlLUTErS0toVnk5bGZ5aTd2Wk43d2pDOUdDVW5wMWFTSVpBN2RTNkVlUVpX?=
 =?utf-8?B?NVVna01tMUJBakhvaHppT3lIdEVHcllFQUZ0RVFCNTg1dno2QU4yTHZlOWRy?=
 =?utf-8?B?NzBYUTFqVnF1b3NTUlpIaWl1MnhjRDZNYTA3SDgwRFVlU0lacmEvV3Y0dlor?=
 =?utf-8?B?MkRST1JUVVBEbmk3ZXZBck80WFVDVXZVODcrRVplS3Y0Mm41WlBrNUg2RkRP?=
 =?utf-8?B?bWk0UDlvQ3JLOU9YMDBJVzFFTUt6cEtHZlp3VkkyTGR2d1VKbTdOOUhlS2NF?=
 =?utf-8?B?WFJzQWxkczk1S2FuQURqZHhhRG5QckNYdFlDWE45Z2NFWUU1VWYyNjR1UUdk?=
 =?utf-8?B?cllrRnFkKzdiN0dwQzRtaHhlbFRJZkZjdVRjMmJRaGhIZ3R3YmFvUnlBSU9I?=
 =?utf-8?B?VytmekRzb3F2TWlwb2Zma2MyaHZpeER4Uk56endWTUZ3UGZoMkE4WDNxdFBz?=
 =?utf-8?B?SFk0MEM2RjlyWUxzWk9rRTR0eHRUTEcrSklqVGJQY2ZRbnhPQ3JsNkRLN0lY?=
 =?utf-8?B?ZU5OcGwvSDlNL2RqV053WWtMK1ZuZC9CdG9JTEJBbldWREFNU1FxaDhwUjda?=
 =?utf-8?B?QXBmdFpOUFhTQmE2czZMWExpOG1kODREM1JWakRvekxmeFpSc09LZGpmMy9F?=
 =?utf-8?B?NmhVcXJpZVVMRU01Zml6QWNSc0p1ZWcvTmNvaVd0TGRGZW9TS2dOL3dVOTc2?=
 =?utf-8?B?SjhuOTZIV0NteFc0NDdrdVRyZHhIU3QzQW55UnMzNDZNUWxZVlE2bldBYjha?=
 =?utf-8?B?YTl4NjZsc2dteHdwRGphWElZU1QwT1g2djdrSitxZS9iVldPM1Q0d0RwcUtw?=
 =?utf-8?B?cVcvQ0M4bmRVVmpkVFVybDNHVG1CbG9FV1pnZUNCZFhQZzJBTHFLZG9JTUxo?=
 =?utf-8?B?d1d0amtwbktEN095VXJ6U3VSanRvcW4zRklmOUdIV3N2K0tqQXJCdXQxaHRt?=
 =?utf-8?B?MDBMRnk5cTNHOEdJZjBRVXUzaU5mMC90UVBNdllYcGtNVC8zRklwTDgvK2tK?=
 =?utf-8?B?QjVmUWF5SU55RGJsS0VReW4vQ0h3WUZVdE55cGp2RjJrWHpEaHR3RzRSS0dG?=
 =?utf-8?B?cjVMM0ZnbU1NdG5tRVNuZ1JPcERFVlo5TUloQUM3M1FyOFFrYTlmNU8yUnNB?=
 =?utf-8?B?eDBTZGRiVmxaMFJQZkpkcDdKOTQzZEx2bVlvVWM4N2NLdWR6cGc4SWJFMTJB?=
 =?utf-8?B?c25VejI5N0FuU0NTaGZjMTFVRHFOdzNqZE9RMEhHQnFSaEU0Y1RPcmFDdDY3?=
 =?utf-8?B?eVlubEIxN0N2WHUwTnFMajArWHc2U3JZbDZpV3N6Zm1PWUQyalRuZDFKZXNZ?=
 =?utf-8?B?UHROVFZKSFBIUUoya1RPZFoxZXd0MlJUV2V2RHN1VXVUVHNsM3dxdjl2UnB4?=
 =?utf-8?B?N0ZNcDhTcDdwbkEyeC9pQjhCTEZOeC9VQWFaeE9VS2kvekJmTkJFazN0ejNv?=
 =?utf-8?Q?gMPYORFU/3FA/QVD4P/Up/XGQa04LXVS+n1x8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a28e84-cf43-4dec-198d-08dacbde1d33
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:33:26.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wugr63XBMbMU7NExg/G+NdSfAL+t0QPW2VP+4J759WAhYzkyzlJ6LQu3ZIQsw6iYu+qSOj/WKH83HAvU8NJvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210128
X-Proofpoint-GUID: dCQs7D5d-BfjipFAnJ4rsDjj0X1p88IR
X-Proofpoint-ORIG-GUID: dCQs7D5d-BfjipFAnJ4rsDjj0X1p88IR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/11/2022 14:28, Maxim Levitsky wrote:
> On Thu, 2022-11-03 at 16:13 +0200, Maxim Levitsky wrote:
>> Add test that tests that on SVM if L1 doesn't intercept SHUTDOWN,
>> then L2 crashes L1 and doesn't crash L2
> I mean doesn't crash L0, sorry for typo.
> 
> Best regards,
> 	Maxim Levitsky
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


>> ---
>>   tools/testing/selftests/kvm/.gitignore        |  1 +
>>   tools/testing/selftests/kvm/Makefile          |  1 +
>>   .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++++
>>   3 files changed, 69 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>> index 2f0d705db9dba5..05d980fb083d17 100644
>> --- a/tools/testing/selftests/kvm/.gitignore
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -41,6 +41,7 @@
>>   /x86_64/svm_vmcall_test
>>   /x86_64/svm_int_ctl_test
>>   /x86_64/svm_nested_soft_inject_test
>> +/x86_64/svm_nested_shutdown_test
>>   /x86_64/sync_regs_test
>>   /x86_64/tsc_msrs_test
>>   /x86_64/tsc_scaling_sync
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 0172eb6cb6eee2..4a2caef2c9396f 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -101,6 +101,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_soft_inject_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/tsc_scaling_sync
>>   TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
>> new file mode 100644
>> index 00000000000000..e73fcdef47bbe9
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * svm_nested_shutdown_test
>> + *
>> + * Copyright (C) 2022, Red Hat, Inc.
>> + *
>> + * Nested SVM testing: test that unintercepted shutdown in L2 doesn't crash the host
>> + */
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "svm_util.h"
>> +
>> +static void l2_guest_code(struct svm_test_data *svm)
>> +{
>> +       __asm__ __volatile__("ud2");
>> +}
>> +
>> +static void l1_guest_code(struct svm_test_data *svm, struct idt_entry *idt)
>> +{
>> +       #define L2_GUEST_STACK_SIZE 64
>> +       unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
>> +       struct vmcb *vmcb = svm->vmcb;
>> +
>> +       generic_svm_setup(svm, l2_guest_code,
>> +                         &l2_guest_stack[L2_GUEST_STACK_SIZE]);
>> +
>> +       vmcb->control.intercept &= ~(BIT(INTERCEPT_SHUTDOWN));
>> +
>> +       idt[6].p   = 0; // #UD is intercepted but its injection will cause #NP
>> +       idt[11].p  = 0; // #NP is not intercepted and will cause another
>> +                       // #NP that will be converted to #DF
>> +       idt[8].p   = 0; // #DF will cause #NP which will cause SHUTDOWN
>> +
>> +       run_guest(vmcb, svm->vmcb_gpa);
>> +
>> +       /* should not reach here */
>> +       GUEST_ASSERT(0);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_run *run;
>> +       vm_vaddr_t svm_gva;
>> +       struct kvm_vm *vm;
>> +
>> +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
>> +
>> +       vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
>> +       vm_init_descriptor_tables(vm);
>> +       vcpu_init_descriptor_tables(vcpu);
>> +
>> +       vcpu_alloc_svm(vm, &svm_gva);
>> +
>> +       vcpu_args_set(vcpu, 2, svm_gva, vm->idt);
>> +       run = vcpu->run;
>> +
>> +       vcpu_run(vcpu);
>> +       TEST_ASSERT(run->exit_reason == KVM_EXIT_SHUTDOWN,
>> +                   "Got exit_reason other than KVM_EXIT_SHUTDOWN: %u (%s)\n",
>> +                   run->exit_reason,
>> +                   exit_reason_str(run->exit_reason));
>> +
>> +       kvm_vm_free(vm);
>> +}
> 
> 

