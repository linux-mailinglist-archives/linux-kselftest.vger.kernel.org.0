Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F07C01A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJJQbb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJJQba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:31:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418D94;
        Tue, 10 Oct 2023 09:31:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AG1JOi028383;
        Tue, 10 Oct 2023 16:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TvPJyMniIkZVs/NvYlerDsv6apreSWCSxZSBXPW5F9w=;
 b=e7O9QVddvN4JXTYCckDYIAhwBUN6E0abEq4Jd2c6qF1AcnFhj/TQHhtB+9FQSy8gZEfN
 LctZ62XwPUK5km4C0S3MJZzEYWrKHkCAESl8PSBIjAK8uGzvQDP01ZRYhjd4D7LlmeRI
 h//UXv1oFiizlpVFCl09R7m9cqvpKaVsSSBR4Hq5yTrBiLBnHPbJMD1KrPdOp1Z8zviI
 6+k2DY707MQczf1hWvR0oYrAimeNZloTmxLJgwgqO1yYKpa3BdVPTzuHBreFGK6bSdXc
 2Ksx+9ny/6XnGDzhyywLBGi2HrPUFWRSsgBv6hfkmCjuMObN/mtJ/1O+wmbC9gzulekV Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh90u287-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 16:31:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AGDc3a013616;
        Tue, 10 Oct 2023 16:31:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws6wd27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 16:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZr6S0taDl1Zvx8TRlHuDAMPdTVGpFBVgotcuwtEhrTgoVhsHkuosRi2rfmsezaoQwFpU8NXIMLcOxzQpIKVRkB9fmzroetGHGmWASyJ6HyiDm66afu3mUX2WZ80tEWhTeimZXksu6HhYitrOkGdv2J8Zv2c3spW7GjjwJsi70k62EbLGBIF9wrcZWDwkGii4M40ZNOPVMBCwOlJamA5aqvQCKXsZmExNIMqV5mzuIRYrsDNu4mQvNnjIEsar66vu7pVpsvWIxtFBsVi399xTslv4Z0k/HMlyCLIWt551isMASdOio4MqZP5QS4K2RcTSjkmnFYuzfzF4C9SxsOaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvPJyMniIkZVs/NvYlerDsv6apreSWCSxZSBXPW5F9w=;
 b=TtOPqtfxAd5YnI7QvYDvCHv2yST/X1pxD+LHHhmxP/H6EN09xsk9lScfJHFWwNwa3vSj79AuUnuwPo1LiVK80GKXTIHV5h46PyexJciZ2v4b76Z07LmYnYldCwg13WbSJbLaXh0E3JpajJ+ki6P4r7bc/GLlTdm7diox7VtgS4hCUKvj7SHcNlCAmEd0SPwfaJx8N/nXOMfHVvj2RJIj90v+WV47essxZqDHpemXCpi0m+j5B473sYHqwB9MpZbjvVWERJBqgkhjbTbaFmjrkx+IT3aT2f0omfvaAfrxyWpSkg8dZdom27FBWFpgDCT3p1dk1dchPNiXHmJUANqghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvPJyMniIkZVs/NvYlerDsv6apreSWCSxZSBXPW5F9w=;
 b=T6ck1l1WXaycWAGciWlzOT6YKzW/QXy9FeBnocYjT4BtbTJJvz07UDpdDJqii8isCJ83wn9DwejGYdJ9teZA+RPXTNAVXIhBc7ZhiylPNernQI7w8F/QEcCCAcQdoB+rG2ToQ4zTHL8VWUHh1xKbqvGQa86O7odQFXF/BcLA5bs=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 16:30:59 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8e27:f49:9cc3:b5af]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8e27:f49:9cc3:b5af%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:30:59 +0000
Message-ID: <2604fa79-b114-60d9-c28d-0d53cd0dc5c7@oracle.com>
Date:   Tue, 10 Oct 2023 09:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, seanjc@google.com, dwmw2@infradead.org,
        joe.jin@oracle.com
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
 <7c2a77bb3ec9f85f684218eb80654adcdfefd60d.camel@redhat.com>
Content-Language: en-US
From:   Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <7c2a77bb3ec9f85f684218eb80654adcdfefd60d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:208:32d::23) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: fa888366-7bf6-4404-5ee2-08dbc9ae493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nepsilMrni9djAhC0l5nXPt9UYOH6/jxj1o1tt6ckXwmJ4QLK5y4seNMAGojCe1NN7watBoFnhgIWrwPHwU917C/FN6oL0rzljiOYs8+wp79ixLYqxbACaff1qyGBa0s5z3j5ZxLWbNjFmJR9PBQHRpMT+XBhTNMarNGLJu1ovGThCkiMuEHq1FAwgRroOnRVx5ygvqbhIxB5nfBIXrg6hYvmEPkzzi/fx0dIztI3KJNSBk8g2NQaCE4lSFCwekcpnii8AqF2Dwx6Ibs3uSm0kuywdpC36ruR5tblqtIxJWSQMERfrjE9jGmkyRDKU2My/mtIDQoDLR5+V2XJLmzB4SegC40OpwLp1rerHgHNMOxRaPD8jZxqsJaDbLD57+EEuDVvMbCKrFbDXJfZK+xVpduHMeIuMV255xai8LHj6YZf42xMBEpRLCyOu/cW3txuBrQ+drl0vEzWLxZUupIpQtkIPBFGewR0ulYitvRssFQBdQl0C3XQtH+tgg9+n8vhzKYe6KDNE2XbW4UNv1Dgvk0Ji/88DmfcidXwsKY/dT/Iag+iCTCO5Z/NPYQZbCD1rEgyKJWlXc868LDO/13vd1xHoRqcXOiUzICxnSMKqsIQLeudltZ7n0rbZxUPSjLsqmMh4nTAu6i7kih+ecopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(2616005)(53546011)(8936002)(6506007)(6512007)(8676002)(6666004)(478600001)(4326008)(83380400001)(2906002)(66476007)(5660300002)(66556008)(66946007)(6486002)(44832011)(316002)(966005)(41300700001)(38100700002)(31696002)(107886003)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVYa01zUG9lOGd1eGEzWGpzU3drdlhqK0RrZ2djSFdCRlVFc0l2TkhWaStU?=
 =?utf-8?B?Q3lvazRCWUE2N2pDSFZZYS81eWVCL0hDL083dWpNQ1daaGJLWFF6T0cxam52?=
 =?utf-8?B?K09MK0g5V0lLNGpnN3RHOUozcE43UzJVZXd0T3d2d0JrTk1QMnY2L3pnV2Zk?=
 =?utf-8?B?Z3JuZEt1VVBiaTA3Y1d5YWxOZnZHNUlxWEhBeUFXSlljejFleUZUTjAxTlpG?=
 =?utf-8?B?K3A2OUxiOGw0WVlyTjA4cVBjRnJZYU1GSGlaSXdnQm1BemV1T3lReUZiVDBT?=
 =?utf-8?B?bFJjN1RMSEhkSXZEbjJXWjNkc2ltdjBaTnRyWTc5VTEybWdCV1NmTUc2d1ps?=
 =?utf-8?B?MEtTK1RkbUEza0ZmVGh4VFlla3FTTlp6N29CUjhMUW40QmcveEdyWGwyNTcx?=
 =?utf-8?B?UGxGeGVwL043MnNCMXZGWDlGcytVS2FFTmxQcmh0akRaNGJvcjMzVEFnZnV5?=
 =?utf-8?B?VGxQb3FmWHNOYkc5YmZkNDYxcHF0amZ4Vk1LRXM0WkZTZjNNaTRSUjZlSXdi?=
 =?utf-8?B?TVBCblJBMDBMd1dPaFl0RkdxNldRd09ONTI3VmhuK1lVcGE0UFFCNnZHeFd0?=
 =?utf-8?B?TzlJUmJjK1JQdEhITnp0QjFkWk04ZFpKS3dWaUNuNE1yaWdqQzdZV2FVcXBL?=
 =?utf-8?B?aHYvR2QreE5qQ2ZUbVNUNVFQbzlvcUduYXZsUk5lNlZkcUM4ZElkYTAxOEp3?=
 =?utf-8?B?UmpUcU9UOWF1ajNrRHJQMUZqSHk5QktTdlMyZGxIWkRlSDBKaTNFWFd3T3o1?=
 =?utf-8?B?NTNqSENOeE1kQVduNTlZT3dOZzB6S1NFa3V3S3VpM29VNzBmNTlaVHgrYmQw?=
 =?utf-8?B?STJTaHBZNXNhenhNMWNTeW5kZUVCNkNDOXFCV1UrMnVtamcxTFk0alJrL2di?=
 =?utf-8?B?MGJLYWJrWU1pQ3hGZDNwUXhoY0VwMjhRbHpMUGtxMndiKzREMXZhazhoYzcv?=
 =?utf-8?B?WnBwNHBMb2dRbHZiZXBMcmtxNVZrUkVZbGk1Y3ZZTXZNNnNWS2o5QlZOMVJF?=
 =?utf-8?B?ajFhR1FXczBENllNeWY0N0cwYVhQUDJxZ0dqM0g5aHJTZGEvUk1hRzVGdXoy?=
 =?utf-8?B?TWJ5blhBSWl4YjhJenJac0FFWjRUWXNNUUlZYkxKUEtkaXdzQS9QS0dVQm5r?=
 =?utf-8?B?ajY2U0dGa0hnZWl5K3ZibGlwZThULzcyMFI0bkRMWFVlaUxld1VhUEtGS1hR?=
 =?utf-8?B?MlR0TUFOMlRSRlcyM1Y0RXR0YVRaNkV2alpiMlVmZDh0Ym1PS3NTamRkalFD?=
 =?utf-8?B?b1FwQ1dZSzRvZHdxNTZJa3RURlp2ZlpFSm00NnNoaC9teTduUUdyOFErWVp0?=
 =?utf-8?B?TzZlbmI5a01RZjg3clh6aXJoWUpZd29TNmhjY2tzQ1A3bGg2ZXFpQ0FiREk0?=
 =?utf-8?B?M1N2ZmdURlhEcVdmUWwxK2JaTkNkNjlyU2MwdHRZV1R5T0ZXOFRnY3M2ME1Z?=
 =?utf-8?B?eHJ2ZW9lV1lOQTNsSUFpWnJHZHZVbWNob2tDZC9ZUnZQMnNvTkx2ZmtnSGdE?=
 =?utf-8?B?VE1XMW1DR0dnczFaN0E2TzBQSEJrdzVjcy9Fc1A0M09ZbTF2MVNIRmwrT01G?=
 =?utf-8?B?Ym50UFFqdUJMd0laN05XYUNuUGJzOEl2bFhHV1MwK0VBeTNhNk5KMTArM29K?=
 =?utf-8?B?N0xTWnlIWjE4VEsxUXBCRzdrKzZ3NnpYZmJJcTRmdnZxenpXcjJZbEZJSzRY?=
 =?utf-8?B?Yjc0aXdadS9BUjZZL3hDUncvNlJvTkllRjhxd2g5Z2VBaW01YWhBendKcWNY?=
 =?utf-8?B?ZnhadEp6QlJmWXl4dWJmL3J2Tkc2di9wd1lma2dDTzBSaVFSSXdxTkZoWjJr?=
 =?utf-8?B?M2s4U0xoUitycWlKYlhodFZ0L3JCeHd3cTdtejBnRkwxM0llZ052SnA3UVk3?=
 =?utf-8?B?eTJQb21FQ1F0bHRBSk5Ta0o2UzRVc1RPU3J4V2RhZ1FzRFh0clY5K2RnR29G?=
 =?utf-8?B?VEkxQVRQTitTTk11ZmFVOHNxNkNpd0hSSmNIRTFQUlJ0U1Z2K2lFUmZSOE5y?=
 =?utf-8?B?d1NXbXMxN0hQVjVobUhKVXZhS0xQeWVYMGw3RVF3TTdFb3lCTHkyQXY0SXhm?=
 =?utf-8?B?SDZWZVlRRmtxaW5oZW4zdFlrUmFianZKOTFTaDdodFQ5OElqa3pmVTdZVnZa?=
 =?utf-8?Q?floKfZFGKpImt8qgAkniOfdyb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GzrA0EFmrZsorTFthDzoCgTlu7VmhLXlDjEby7O8tZEJGpQtwn78AhV7i96cOb7oOZqmxOwyGotOfn/RA6FZw5CnMfVgZaDt981bj0/Ji/SoKFgmYS5yHE+lx+GNIsd7M55TeaqPZatT2mrKuH7UI9hJMXf0yhd9Z4RoOdQvQ+MzBBsdw2Gu//C9I/8a5R2+HrO4Ortl9YPPq7nx807NsosexLMhtWGMaVWGIPWicgcNSaFEJ8r8plKwWXBIE9NYdgaIaoLrDw/dzooqJdVe/EFmC5IRHOcYKSVtRo6DFUgG1spvgKIUR2xYTSf2ZiQzudSbxPjx1Jfoy2Gd2s0UH39i8Dv08PB6uVXZwDA/9jO1tIV6tD3nf1FQPti/XeBPjmHvPvbUgNMR+Pl/RmbxokyUxi+x6SoLY3s7MGpCv6t+zRY8l1vxNA7qpyXLgxMVNIx2FPXNTio94IzoA5BJ3s2neAqlWRsoZVegQllYnJAlMOTxjwrlVCwo521IjyzreuAXnDYtHYisbsSYlsqLZj3ju8KnU603zliDFP4+dIu7GAt584ruqUKnpY1KLagkyT+aHfIO1zEn2Vy4s9Sc12GJLukKCgh0PaANfWydsN0gQt/Iwe+RAkHHt85MvP1xc6ZMbmo4CwNU9+Lep63UrjMLbyme1Umeym71S+XfND/fjzhzq4SYvo6+UDKi/5nCdsx2Hg+UDPZLE7KVjBWL5b29/vGszP6VAQvkyFvIJuiGWgM+WEgTWj+G6zvCRHCnbhSnguwMcNFvU9grSCRrA63F+29DfJJiLIEWbXniT5eNJlIRiWltgyy+f4fezDuUEX73cTiS2xjCrCywOTpFRrkOji9sx0jrBOyjkYGPSgspotSX8PpBgHhQrCjPBsvHM3U0H3b33a4/w0fiPismvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa888366-7bf6-4404-5ee2-08dbc9ae493b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:30:59.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJBmCi904Ju4PVzP2t3jtVjOJ7X9K+0ELC8we34Am1Ea1fIMKT7997yAIFCqxzDlacIfUX46n/9hvFS8ngNldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_12,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100123
X-Proofpoint-GUID: P_zuSPrbE_2Idr6O2fC7LbMKP544PziG
X-Proofpoint-ORIG-GUID: P_zuSPrbE_2Idr6O2fC7LbMKP544PziG
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maxim,

On 10/10/23 09:13, Maxim Levitsky wrote:
> У пт, 2023-10-06 у 10:57 -0700, Dongli Zhang пише:
>> As inspired by the discussion in [1], the boottime wallclock may drift due
>> to the fact that the masterclock (or host monotonic clock) and kvmclock are
>> calculated based on the algorithms in different domains.
>>
>> This is to introduce a testcase to print the boottime wallclock
>> periodically to help diagnose the wallclock drift issue in the future.
>>
>> The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
>> wallclock nanoseconds immediately.
>>
>> References:
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20231001111313.77586-1-nsaenz@amazon.com__;!!ACWV5N9M2RV99hQ!MOnoujF4PlfvZ3SUuyXgIpJC5mWiE5uLUsNW6AWgirGXcObN5uil_fnthRVcYaPA0N2uoNyLChBogHC7ZS6t$ 
>>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   3 +-
>>  .../selftests/kvm/x86_64/boottime_wallclock.c | 100 ++++++++++++++++++
>>  2 files changed, 102 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index a3bb36fb3cfc..fea05b0118de 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -60,7 +60,8 @@ LIBKVM_riscv += lib/riscv/ucall.c
>>  TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
>>  
>>  # Compiled test targets
>> -TEST_GEN_PROGS_x86_64 = x86_64/cpuid_test
>> +TEST_GEN_PROGS_x86_64 = x86_64/boottime_wallclock
>> +TEST_GEN_PROGS_x86_64 += x86_64/cpuid_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/dirty_log_page_splitting_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
>> diff --git a/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
>> new file mode 100644
>> index 000000000000..cc48c9b19920
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/boottime_wallclock.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Oracle and/or its affiliates.
>> + */
>> +
>> +#include <asm/kvm_para.h>
>> +#include <asm/pvclock-abi.h>
>> +
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +
>> +static int period = 10;
>> +
>> +#define GUEST_SYNC_WALLCLOCK(__stage, __val)                        \
>> +		GUEST_SYNC_ARGS(__stage, __val, 0, 0, 0)
>> +
>> +static void guest_main(vm_paddr_t wc_pa, struct pvclock_wall_clock *wc)
>> +{
>> +	uint64_t wallclock;
>> +
>> +	while (true) {
>> +		wrmsr(MSR_KVM_WALL_CLOCK_NEW, wc_pa);
>> +
>> +		wallclock = wc->sec * NSEC_PER_SEC + wc->nsec;
>> +
>> +		GUEST_SYNC_WALLCLOCK(0, wallclock);
> 
> Won't this fill the output very fast?
> Do you think it will be worth it to wait some time (e.g 1 second or at least 1/10 of a second)
> between each print?

The wait time is controlled by the VMM side (of selftest) as in below.

In the while loop at VMM side, it sleeps for a period (configurable argument),
until it runs into the guest again.

Therefore, the user can decide the frequency to print the boottime wallclock.

+static void enter_guest(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	while (true) {
+		vcpu_run(vcpu); -----------> to schedule guest vcpu here
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			handle_sync(&uc);
+			break;
+		case UCALL_ABORT:
+			handle_abort(&uc);
+			return;
+		default:
+			TEST_ASSERT(0, "unhandled ucall: %ld\n", uc.cmd);
+			return;
+		}
+
+		sleep(period);  ------------> sleep here
+	}
+}

Thank you very much!

Dongli Zhang

> 
>> +	}
>> +}
>> +
>> +static void handle_sync(struct ucall *uc)
>> +{
>> +	uint64_t wallclock;
>> +
>> +	wallclock = uc->args[2];
>> +
>> +	pr_info("Boottime wallclock value: %"PRIu64" ns\n", wallclock);
>> +}
>> +
>> +static void handle_abort(struct ucall *uc)
>> +{
>> +	REPORT_GUEST_ASSERT(*uc);
>> +}
>> +
>> +static void enter_guest(struct kvm_vcpu *vcpu)
>> +{
>> +	struct ucall uc;
>> +
>> +	while (true) {
>> +		vcpu_run(vcpu);
>> +
>> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +
>> +		switch (get_ucall(vcpu, &uc)) {
>> +		case UCALL_SYNC:
>> +			handle_sync(&uc);
>> +			break;
>> +		case UCALL_ABORT:
>> +			handle_abort(&uc);
>> +			return;
>> +		default:
>> +			TEST_ASSERT(0, "unhandled ucall: %ld\n", uc.cmd);
>> +			return;
>> +		}
>> +
>> +		sleep(period);
>> +	}
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	vm_vaddr_t wc_gva;
>> +	vm_paddr_t wc_gpa;
>> +	int opt;
>> +
>> +	while ((opt = getopt(argc, argv, "p:h")) != -1) {
>> +		switch (opt) {
>> +		case 'p':
>> +			period = atoi_positive("The period (seconds)", optarg);
>> +			break;
>> +		case 'h':
>> +		default:
>> +			pr_info("usage: %s [-p period (seconds)]\n", argv[0]);
>> +			exit(1);
>> +		}
>> +	}
>> +
>> +	pr_info("Capture boottime wallclock every %d seconds.\n", period);
>> +	pr_info("Stop with Ctrl + c.\n\n");
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
>> +
>> +	wc_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000);
>> +	wc_gpa = addr_gva2gpa(vm, wc_gva);
>> +	vcpu_args_set(vcpu, 2, wc_gpa, wc_gva);
>> +
>> +	enter_guest(vcpu);
>> +	kvm_vm_free(vm);
>> +}
> 
> 
> Best regards,
> 	Maxim Levitsky
> 
> 
