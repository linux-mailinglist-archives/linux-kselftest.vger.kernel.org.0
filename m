Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FA7D11B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377495AbjJTOj0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTOjZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 10:39:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C66114;
        Fri, 20 Oct 2023 07:39:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KD7d51013019;
        Fri, 20 Oct 2023 14:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9tIIyuuF04P+aSzfIGe6Zoj1bP20ERzIPxNQ0/P8wKs=;
 b=HRslWG7tutzS9qAYJl3fciRuWUV7gTTTQ/+YdGCqogNUpdKlxSFwA1sz76mVQwZ5efbL
 v3KkABGr13e/+DRUz5HUUXDlKZ34OEnJ7cxQAgDYhvP1JGe/9BKAiqPTosMeHzCsCMTy
 EfWU3aBN21nJuOGOt640TK9Cw0fyPBKgcvqYH4nchjOOvNt1CaVzcCkZDkwZRFo7m7hM
 mVYh5KZtqiI9LTfTr/1eNTUz6N/cPfYhUxk0BjR2DPJPz1pey70/VqCG3hD1U2Yq4b7f
 EXreIvq20pFVS35uvwD0OQpFNjss3zbHzhiNzz8F65IUMRM0e/tjk1dy0EnQRBfaJqnS PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwba0cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 14:39:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39KCvbIq031347;
        Fri, 20 Oct 2023 14:39:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwdvx0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 14:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnGDqj5NT5tu/zE6rzjn/82tBNKLGs2uBPYxDghN4Dmkzn26lpVGAz8A1EpUwpRcIUe4uPCLrPkDmdUcF/dBbHFfh9w23vQqU8mWyW9R6ohDIRmaySktPeMBIUo8CPF/WOYBBnfPK4BjTIZdWjLFcMqmKZA7TNh8ftgS+zljnZY69T25u8scA7F+ydBEjHmXDWS26k1/wrx3SaVqSltjBg+CGnUQeQd5+g17vulwm2MFBa1kA+i1K2x3TlDMmKnrJEyNc+EBz6PxMvHJnA2WPQ49mdlWxGZWRAIXmOqERZdpkxfi8W5VvTV0k//EkycvvISYF79W4ebCzKtoGncvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tIIyuuF04P+aSzfIGe6Zoj1bP20ERzIPxNQ0/P8wKs=;
 b=SF9haX2OFgsPiBU/84XgLaOv/jxSSr4s/gOr/MPBqgx7F3U0JQjS+kuW2MFEDMWKJ2FKUJWvNIlgQmHFe00yUor355czrTRifXdYVdNvZxSQXeA9jheAas5v7tfGRBtAhHHHsQ2HXPyZHB8kesAs2SYCqSFD31ED8aAPmyYWl67+gePeu6cJv9toTNu8vAmQhaQf2uIAx3FLAImBGOyrlhVNPqHYek1d9p+EPo9OIkmwSWwUYzQa87Di8pbG0CT2oZxSylK6GR3aOqt8mI9ar3pH+H6sKdecdVncmhXpuY2IqISIUtLbWu8K8G8pLYS+xczZFZksvVkRaVu3SGhQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tIIyuuF04P+aSzfIGe6Zoj1bP20ERzIPxNQ0/P8wKs=;
 b=VMFo3/qSa8xsoIwH2fIGve4j0CLKjIp7qRvvXX25haKYgzR51TG4v/bOzFoeTQ0MarI0eR/NfMuAn4Dhf/8Kqb//e6rU+F5vDj5jg8ryFmQLZnJXb8yHqeCIZyWW2pI5/YxXYTCZ4gUNTgI7Nc17zkQ8cSkvHCakOIMP2AST46s=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by IA1PR10MB7488.namprd10.prod.outlook.com (2603:10b6:208:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 14:39:08 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8e27:f49:9cc3:b5af]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8e27:f49:9cc3:b5af%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 14:39:08 +0000
Message-ID: <bbddbf1f-33c1-cdae-9e0a-a05403bf44bd@oracle.com>
Date:   Fri, 20 Oct 2023 07:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, dwmw2@infradead.org, joe.jin@oracle.com
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
 <ZTA3W-f4sOX3LHfi@google.com> <20231019-f96a45af9c235d89be644e67@orel>
From:   Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231019-f96a45af9c235d89be644e67@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|IA1PR10MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: da3de50b-45d6-45fc-5283-08dbd17a511e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+GMNGBdP6+jk/WKC2XgZXyeSs/AKnpcIy1QUUngtQmM6tsxgupoioJG8764DZRCnpUf3ottlq1ex0ANZ6rUEqbKPbhCzEdnrj2cnSPd8gZL6W1tuo2etVFwZbnFQrs3kPvQxptvvJb+T1QQ1b5F4V/kdoakSw3ut9frAUCuiu+d+q5IotGzXC3Hlw+HWJ6zJH59IjkYc5lTXCySQW73bDfT3ysJ/2QCvrsw6MmAhJ/cZTD4yjTNO+W/Ssf+8dgsCC0SlaCMpLjG3zNG2D4HFgLcVCeEZqutaJviXCmcSCX0wQ+V5Z2HF758W8kNfYJdpS8+HYrWncmTN17omKk9Rgt+KFFZqokl0DJ7oiBF+/OpQN9YNnRkEEZHJJIYx6xXL+Aom38eTTrCoCZDVgIzDk5OJfn6jJEYvKntnLf5r0zEBvZVnYyrnDTGuV7ykZddbZDsa6iPOzEcBnmVdgmDN2lAd69kgkrrJMkKJUo23XRcpqeMjS7D9qmoDChvXXdRdZLJHhcnQ8zbjraqvesXFC4slDNyvXOQHc2CppA7Nl79o5pCDzOhBAR1/9mtxKJ8dhEqrJ4Mtr/bIl3JSvh4aLmTd0pT9eK16I+cye/gq2h+ZTigyyN20TtvrPZwdC4btk7R7e+dthDiDAZOwMVv1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(31696002)(6512007)(6666004)(6506007)(38100700002)(107886003)(83380400001)(86362001)(66946007)(66556008)(26005)(66476007)(110136005)(2616005)(31686004)(316002)(53546011)(36756003)(966005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG0yTHhmU281aHNjczZydDRlWUt2N3ZxQVBCVFpLNStHUzQ2b3czaC9BU2tC?=
 =?utf-8?B?L0ZpRmJDY21ZZkxhdm1Hdjg1VzVaL3RtekJPODRzRmhIL09va1hqa1htR2lJ?=
 =?utf-8?B?bzc2dXBGWnZUMGQwZFFiME95cTU4UHU2aUtuYzN4ZFlLeS96c0dWN0VEb3Va?=
 =?utf-8?B?T1JmVFRodzYyOVZlNmtWcEpOQnUrOFR0SXBXb284eHp3KzJLa1ZkYzFHWkVD?=
 =?utf-8?B?MUVHRU40eExoeHZCbUpNNndITFRsUVJvNW9vT2t2MjFYWDVreEJIOVdZYnRT?=
 =?utf-8?B?UGVyNm11ZEtMSkJBOGR1ME8rcSs5QzU0NTliNEJza3RNNVhlT0ZxVlRJZDFH?=
 =?utf-8?B?M2pHU0xuNmZOL09zbXlVc3Z3cFNuZDVnWU5WdmhUbXlCTFVPOTA4eHN3T0RD?=
 =?utf-8?B?ZlNPckJmSVBRN0JNQmNlVEY1YXRVNytCangzR1hNWGJMRzdEWkFZaTQ2eWlm?=
 =?utf-8?B?OHdscHg4VmpmMTlueWZkVkoyVFVhNXlLdnNEa2pmc3VneHh6M3VqQVQ0Y2E2?=
 =?utf-8?B?eVdlM01YVWNmVHRITlpUaXdFdEc2N0NXWUM2YkN2UW5xOGFJRXNGK3E4b084?=
 =?utf-8?B?Mlc5VVJNdkVpT2ZxaFgzeWQvd3JOMkpNc3owMFZvZW9iTzl0VDhOY0tzblpO?=
 =?utf-8?B?bE85bTY1TWxSc1Rlb2hPVjJSVTBqMUJ3bU5qVEM1MXJidWg3Q1cxaURsODVh?=
 =?utf-8?B?eEpLbWNCTzhXUnZDTFpzT3JTdkN4M3B0Yk5Bd01JaFgwc1dkZERYMGZDOUgv?=
 =?utf-8?B?WTZXdk9aQ3Iyb3VtWUF2aFViL0xNNE1Tc25RWGpzc2Rtd3h2enhiVWVHa3g1?=
 =?utf-8?B?UEhmb084SnpOR3B0bVIwcDNTY3ZZcWNUdW81WGNnUFphTUE2QkRKNGVYTnh1?=
 =?utf-8?B?N0tDWVBEaUFXL2hjODFBWjNIdU9ZVk8rNm1BQzZTWm5SY0YzTnFJeGx0TTN1?=
 =?utf-8?B?TnMzTFpCMTYyMTZGelQ0d0N2S3o5b291SlVMdmc1VHErTHlRTndHdmora1F1?=
 =?utf-8?B?VFQrYy9FV01sMlVVYWpDcEUyR0trb2UrOEFYUVFucGxPdDlHMDVQd1NiS2JB?=
 =?utf-8?B?L3VJWVNWS01XMURseWFIQmh6ZW1wUGlyV2NTMHZyNncxeHp2dEZZR0VaS1Nw?=
 =?utf-8?B?ZWJhT3hFa0o4dk4ySlQwbnhkTWFvZkFTR2o0elBuaDQrMndsVDRwMmd2bzRw?=
 =?utf-8?B?NnZxOU9kVHhtN1hRZlZTdFRVNi9QeHVTcWRsWThpeGRWSEt1U2Q5aitoN0Jt?=
 =?utf-8?B?RUlzRWpId2ZlQnJXOWRUaGMvNHBpWGN0ZFE2YVlkbGFOTVNqYVBNMmN0a0pO?=
 =?utf-8?B?MHFOS2FtQTFUbFV2MXpnTkFVZGNSeng1OVg4cXRBRHdza3RhaE9kYkpjN2Ew?=
 =?utf-8?B?aURkVCthSzFvNXZnSXV2Wm9lV095bS9HY3h4cnJUeHJBZnh6SVpuRDN4T1ZS?=
 =?utf-8?B?a29vNlZMOWFBNUpCWFBnd3g1TnUwQUZ3TjFmMm5ZMWNCcGV6bUdaRENoU1V3?=
 =?utf-8?B?QkVIUzJONFV6blNWV3NlS2VocERwMmE1TUs1RUx2UEs0NW9ScEIvb1ZpUi9M?=
 =?utf-8?B?WEcvNTc2UzFiMERidGhleThmejQxUEx4SXMvb21ZaXBTTXU1bHYyU2JhYVFy?=
 =?utf-8?B?OTN3WmJXK25FbnpiL2tKNzlSb2xNYzdTZDZRMUJPM0grUGpkQS9PNEYvUmll?=
 =?utf-8?B?K050S2Z3dXFpS1pKZnVFc3pueHEyRHNxUFNRVG9mUS95WTdxUzc5SHFLck03?=
 =?utf-8?B?VXF2cmxZY3lSTkdNY0xyTEZDR0NNQkN1M25KVVErVEJRUkwxL2RuZ1JsZG5Y?=
 =?utf-8?B?Sm5Ua1QvN2NSc0k1N2NZSGE5YTFxblZVRGVTeHpIMml5NHM5WGxvMHNPYi9h?=
 =?utf-8?B?U2RJd3Z5eWg3SXA4MWt4L0ZSZWdZOUxzUHdZazAvdmdLQjF1YkdiSU1sQkFO?=
 =?utf-8?B?cWl5amd3YlZOMkNmNWNuSlFid2ZTSjFXRy9vbE5GZTZ4N0hNZDBpK2t3Rk1p?=
 =?utf-8?B?TjhIL3k4a2laVkd2S0hzNkVTRUY2MUFGdHNwSTN0Z3BOZkVhdDQzcGNqbitp?=
 =?utf-8?B?TUtwbGRQREdGZlAwclFRbzNSaW4wRktKdGNyZjFUM1ZiNGdFSSszV0RqR25V?=
 =?utf-8?Q?/uDZL1uCzpDDJIIqXb+1wJATH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SEhoTTYwc0dZWU1QdDhCWWtOSGZUUllZaXRYVVNTTzNSZ2lHOGorWENqUVlm?=
 =?utf-8?B?dTFUdlhyZThvZVZwalhMY0dwa1dhbmJVRmVwbThtcnBVNElSN2NEcVpYaFFl?=
 =?utf-8?B?d09DVDIxTFE5a3lFTHVSZ21hQkQwSTh0Z1JuWGtzSkhYOHVXbFNpOEpjQTBw?=
 =?utf-8?B?bGN5QXQzVit3OWNTYUpmZHJmbGNsemp5WkFvUzlWVGhPMUN0Tlh3WndtK3o1?=
 =?utf-8?B?bmxlS1NDSlVRcyt3WmlDNE8rQW1xSEcyRU1lNTZGYUFrUG90bmRLd3BVVTll?=
 =?utf-8?B?ZEtBbGlwTkFBMFh2QkZTVnZhYWF5RFM1WG1FeUF1eHg5UlF4cEdQc2hxSk5N?=
 =?utf-8?B?TTRIZGFBOUxvempBM0YyNUpsRG1rcTIyL2dDVGxhUFBOajBJNTJOS3JUanpM?=
 =?utf-8?B?WldKZUZZTXR2b2VpYmwvS0pDYTAwZkV6UHg1Mzc5MG1VNmVFb0hkcnFiblds?=
 =?utf-8?B?cFlhSCthV1RTTUlSMENqcGpJV2RzdG9DZzM4VTdpN1MzOUxYdkxnMEovajRB?=
 =?utf-8?B?elk2d1BWNnpDaHV5aVdyWTZjeDdndy9VaDJXWDRyVEV2ZldrS2V5ZjIrcHRx?=
 =?utf-8?B?WjVCMVkreVk0MDJQVDFIVUtKWi9OaTJZUVUwVVozNGJiNUoxVndBakQwZVpQ?=
 =?utf-8?B?dlZnT2UyZFh6YmpzV0lrWVJvdHIxcnoxYkNTUlEvVU56OEN1UjZFTDhKNytw?=
 =?utf-8?B?V1FpaitRa0FnSHRyTGlEUXVrZ3Y0YmRuY3drQ21KcWNHcG1YdFVabTYzUVhw?=
 =?utf-8?B?RWc0NGo4UlY4TUdkby8vMVhHTnBTNTgyRGhGVUtGWVhJQ1pyN0tHQS9nNDJZ?=
 =?utf-8?B?T3AzUHVRTWdpMmRzZnBBdUV3TUtkT2crVGtiSUh6MjhwMnpHblFDb3FLd2Jt?=
 =?utf-8?B?dHVzOG5ERmpiaXUyQmlTQit4QXVKZ2VlT1JiQjYvaXprb2twbGZ1WjJVemU2?=
 =?utf-8?B?MHI0dm1KR3RXSjY1RmZQbllpNWxpWWJrOStsZndKS2ovdGs0QmZ4RTlrU1I5?=
 =?utf-8?B?MVlGWWRUZnl3SFlCaWRaOTN1cVpuM2NrZmlXUHZaNnJvVTZNU00rN25XUDh0?=
 =?utf-8?B?aTF0dnJhc3NtRVBYUi9sOExmaWhIdWNxb2h6WmFIcEhpU3pFSXNvcmc0a3cy?=
 =?utf-8?B?MklIZko2TGQ4OHZ5THcyVnlPMGxCMTVtb2hOckZFZU1jWHdyL3ZFL3dRaWhk?=
 =?utf-8?B?K2Q5K3pqS0dzVExXZTRGQWdYd1I0cm1ZMFJZYXplV0FLclFoTWJQSk12TWtQ?=
 =?utf-8?Q?7IkTQAQy8tgspND?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3de50b-45d6-45fc-5283-08dbd17a511e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:39:08.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXVTowErdROc0EVFpQLrrmODVV8lNHJZf7x/c/eKu5fcnzXjyOZIPqKfkJcJSlLyMYGVKjdN1wpgqXC3bO/BSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200121
X-Proofpoint-GUID: ya29xi4ao20IUpHWk69GZzLbnvcNzi3T
X-Proofpoint-ORIG-GUID: ya29xi4ao20IUpHWk69GZzLbnvcNzi3T
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sean and Andrew,

On 10/18/23 23:51, Andrew Jones wrote:
> On Wed, Oct 18, 2023 at 12:51:55PM -0700, Sean Christopherson wrote:
>> On Fri, Oct 06, 2023, Dongli Zhang wrote:
>>> As inspired by the discussion in [1], the boottime wallclock may drift due
>>> to the fact that the masterclock (or host monotonic clock) and kvmclock are
>>> calculated based on the algorithms in different domains.
>>>
>>> This is to introduce a testcase to print the boottime wallclock
>>> periodically to help diagnose the wallclock drift issue in the future.
>>>
>>> The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
>>> wallclock nanoseconds immediately.
>>
>> This doesn't actually test anything of interest though.  IIUC, it requires a human
>> looking at the output for it to provide any value.  And it requires a manual
>> cancelation, which makes it even less suitable for selftests.
>>
>> I like the idea, e.g. I bet there are more utilities that could be written that
>> utilize the selftests infrastructure, just not sure what to do with this (assuming
>> it can't be massaged into an actual test).

Thank you very much for the suggestion.

Would that work if I turn it into a test:

1. Capture boottime_wallclock_01.
2. Wait for 10-second by default (configurable, e.g., max 60-second)
3. Capture boottime_wallclock_02.
4. Report error if drift.


I have another pvclock vCPU hotplug test with the same flow.

Thank you very much!

Dongli Zhang

> 
> Yes, there's definitely code overlap between selftests and [debug/test]
> utilities. For example, I snuck a utility into [1]. For that one, without
> any command line parameters it runs as a typical test. Given command line
> input, it behaves as a utility (which developers may use for additional
> platform-specific testing). It seems like we need a way to build and
> organize these types of things separately, i.e. a utility should probably
> be in tools/$DIR not tools/testing/selftests/$DIR. For [1], I don't have
> much of an excuse for not just splitting the two functionalities into two
> files, but, for KVM selftests, we'd need to find a way to share the
> framework.
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20231011135610.122850-14-ajones@ventanamicro.com/__;!!ACWV5N9M2RV99hQ!LuJ92LOR4jVJfhj8M0J9MUqP7520s259wSzAdAL1cV0zNrzVB2W0F_5gpEVX_SoHeKuivIt-VIVB6jaN5EuIKA$ 
> 
> Thanks,
> drew
