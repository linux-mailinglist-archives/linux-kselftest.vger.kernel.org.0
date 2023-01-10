Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66300664452
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjAJPSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjAJPR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 10:17:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74A50E74;
        Tue, 10 Jan 2023 07:17:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ADL4BJ031725;
        Tue, 10 Jan 2023 15:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GwXfqeM50PQgjwvSKDXjRW1Y9fcA+s1F0Jyw/LD0w2Q=;
 b=l0fq3Y9pfJtY7B6uJFbZcm/W0c8/hK6wyaVFN52flLmNRFYxATV1QSlOhEMcwsc6ZlPU
 jA3evM9/oLnSNSelk+nrSVDpBDRfa+UVSxKySA2mDzdpu7UP6lSYAOL9ymgVDOxtIKxo
 Rt698oSDTOWugHl6lTfl2WgqBnuFMlYDoPfNz2b1rI0QjlzVJNLj6AL32AcMzab1s4QU
 S7RoKC5tbu7o3b5XSHX8ZNJjRJYk7AydsxTm5Ew7/oPYfO/76iy+uhaoLfuXIltMr6E+
 sb4hrjfxAIfZoMzIDG9ultRXsbxj4orVFl9u1XFz2m/7SnDlmCHgc9BtTNEjg50tCaZc Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t8cbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:16:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AEmr04008149;
        Tue, 10 Jan 2023 15:16:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1a439eum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:16:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQfQxsv6wbprrTNSyGQafFkU1eFlkfiGXamT4P9MrSrk1g+y5652WJ5xWfe4xkAIE8Qctx2oB21gg0nqcmbj1YWnOP1TqkSEiewTuoMx0luStRCY2MltR4Gx9BCCpzrpqFCKMeFemTom3USLXfEzjrZNWMoXzBKK/HC9b4lQXs16Icv1rUiD0YcpHPh7iLLTtK77e0Ou3iSa7u50njbRAUi6hTQiP7C4bo/zayY0QOvdA0aFsVv5KeSbeD7QYvkum/8DG1InP7ptswfbTsGYaKODxorBYVILM2CgkbAsngc8vcYIVG8kO+7Pjyt5DcAtgU8YIjDFMIXASDEs5Z9BOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwXfqeM50PQgjwvSKDXjRW1Y9fcA+s1F0Jyw/LD0w2Q=;
 b=QSAZhZ7qyvFzQLeEL76vkJRfj4IlXDUMtbB4jutk3geeuxuYOvMNj7aqoIxxHI+cZZTlOOwBu7OQ83O3/6S1nUD0H5V+SSDlNf0zxyij738NL9f5X0q4+/YiXlwuDGhZ7wNux/zMwoQM1WzCSI3Dj/Trt0eKohpGkwlj3FxgEnpjyRJYDLTeUs1y1r/NRo9UprrSdRLkEOyg/+e6ra6XIlMh/CceBviDA3t6neDIHBsiPM/XHTIyRzWfVDVR1kiPPclAEN28FxxHgyVCRROc5oHDT2mq2NZXi0WIcvHxl3DdIwi66cG2EK6jtz7W/fU1dreBtHBjl87aXV60hz6rIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwXfqeM50PQgjwvSKDXjRW1Y9fcA+s1F0Jyw/LD0w2Q=;
 b=w5Yv0K97Bkn2XNW3vo8bnLZH3lfytcSFabkHyPfgPaQg4nkqefCT5Osfp8b90RLs4/cOUnvyyJe6xUlWXqS4g4p2wR+xanSKCApJUPW/t4bkiyaDbFo6hYE2nOM0WlYC1APCiK+OqWrGML0ttnfRbRhA0Mz9S2SIxrwbSxV78BY=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA2PR10MB4698.namprd10.prod.outlook.com (2603:10b6:806:113::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 15:16:32 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b6bd:f4a8:b96f:cf5]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b6bd:f4a8:b96f:cf5%7]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 15:16:32 +0000
Message-ID: <5481b0e8-84dc-52a9-c99f-1df3417328d6@oracle.com>
Date:   Tue, 10 Jan 2023 15:16:23 +0000
Subject: Re: [PATCH v4 00/17] IOMMUFD Generic interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
 <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
 <36b0fdac061e4680b5966d2774f0026a@huawei.com> <Y71szSt7jRFKTMcl@nvidia.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Y71szSt7jRFKTMcl@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::34) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA2PR10MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7a8616-96f3-4044-aeed-08daf31da7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7hFNcTZLRkAFqXLufCvVuLla/PiFaXU9PcFZHVbmPEaTLYSe85NrORYUxYAEMVx6prGp2uwPmTlzrV/cY+Wt49l9ZSPpEMxhw/sldntYnAE6yskJl689PYGaz3bkC90PO1UCyxzGyhO52gDzmVCEuyY+wILSP59A3WdwD0FbYPIIDglRco4JNNeLcRUsRql7g7Um3rf0PkA3yZ4WG8H+3K3IZfR1I3Uu8xfjCcwMcvV025nLu6ADX28OcP1JJ2OjNrQg1NZTSOkHL7ZVeCOw8yLhh/eaNIJkvM6GFYrKOHJXN/ygTQjqys7ws6eeMpk0xl4tDAC2y9n4sDG4DD95/7/DTXKPbodVe0AL0BCBu7hwwgleA7i5V0f7JrwcgxpPxFl8YgNcgGt9YdCSIOg9Md5bBkI0qTNOfsQ4GDhlVjeDTgvo7TzJel/xfSpHlDzqwxUmwQu61FgOKm3BbG8KKxYgjq0LYB0nS6B5F+TlzNeF2oJ1w9zWfWNQqJJ+mV5LYaNXz7YurpGmK0uMmVjLv+MTQRNfpJ6S6IjLYDTDoXdNG/t5ukkcffDDLuKhevm/Nq3jOaeMmPY4VRXPPdq1KzTNP3s+x8H+Yxg9lIuzr/mTXlI8ihDdZEuVKOoE/Ma44AFwbsYbhqjXNt+ACP+CGrQtl0ch+YsRJGvde8AedG5oxYgfYR43lMEYZxExlSAi4GmyOQ3g5D9QX3cz58y5DiY+VcSDhFiZdrj0aBufak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199015)(31686004)(110136005)(54906003)(2906002)(5660300002)(4744005)(31696002)(86362001)(36756003)(7406005)(8936002)(7416002)(41300700001)(4326008)(8676002)(66946007)(66556008)(66476007)(38100700002)(316002)(6506007)(53546011)(6486002)(26005)(186003)(2616005)(6512007)(6666004)(478600001)(41533002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRuZTZUQzdFWUM3elExZUIyWHZnblNETHppQjNGUzFWbStFWE9QVG1HcS8r?=
 =?utf-8?B?cElQNWIzeXM4eDAzV3FyclMwbnFiUFpENkVRa0FOaU9uY2ExV25CakM1NFEz?=
 =?utf-8?B?R3ZJNlpSZU1VaVdiUFZsdkltMnc0SHBDV1UyV1pwSitTL1NBMTBkRUxBc0dC?=
 =?utf-8?B?a0Q1QlFHTVkxTUg5UG5qTGRrU2Z5UTJ6YmhtaWFZZ3FPalRTbldyZmhnbVN2?=
 =?utf-8?B?SXRrUWQxSENXZTRCRExFd1c4QU9NZExFK0Q1Z0tYU2ZPWEJaNHlQUFl1OS9a?=
 =?utf-8?B?L3RaZ2JPem5zVW10enZWOUU3b0srRFNxRTJsNHZCUitHSFNGemNoWkowWkZE?=
 =?utf-8?B?bktGTDBrSS9mQjBtMHIwTGdadS9CaHRTdWdyZ1VZVFRVUitKV2lhT0t5cVpw?=
 =?utf-8?B?L1JjL1RLTGZYcFB1emM5VTlBbWkrbXBNTW1Cak9nU3Fad0hqdStUUUJBaWlw?=
 =?utf-8?B?OCtNeXhjT0VKYnpMdUV2NEEvcU9qTUU1M1F1RHhsY0UxYW5aZi9OT1lTSVpr?=
 =?utf-8?B?eWNCQnRHYlJkbjRqTnVKZ0FhNnhOTVA1WGlRMXQyZmNiZ1JONm13K2pJYTM4?=
 =?utf-8?B?VStpejlLUzZ4Z0tHUUNyK0xSWWdYMDFPWGcvc0Q0d3JpY0lTdHMxbm96MXBr?=
 =?utf-8?B?VmU2ZFFCSkUvYnd3c2lSUFB1eXRIMWFqOEpNbGplcG0vMkF5ZzIyYVVKWHl6?=
 =?utf-8?B?L3lNSkJmNE5pWlNibVdGTTV0bElCempkbFVLY09icjkwM2MrdGFSbldkSk1U?=
 =?utf-8?B?MTE3ZUJSWHovS2VhK0JmWHByb2t5dzVLc0I0WVllWXE0cGtjc2dYRktremh3?=
 =?utf-8?B?dU4zdFludGRmQzNBaEhLREo3RUp2K0Z2Z29Jdkk5ZDVJNUlxMlNkbGpmcEt0?=
 =?utf-8?B?T0I4Nkg1VThXdEg2cGdYSTlraWZrQVdYeDEzTml1dEtzWnJPcm9WbDZkM2dX?=
 =?utf-8?B?ZjBxazNlSlNjTXc3b2RjWm41RHZWZHBxbDVWbXc2TVp0SlE0eWd0ekQ1dmxK?=
 =?utf-8?B?UWRDUDhmN0N5aE5xSzVzYjEzbGl3MFVVZkVvb3U3M2ZUTGtsT21OcFpISk1G?=
 =?utf-8?B?ZzM4bDFIRTFtcUt2WnhiRTZmZ1hFS1o4aVlwYXdLN1NaMjU0WEhvdlE3TUVv?=
 =?utf-8?B?OVVTZ3p6d29nWGVmVjJMU3RvV3VQdHNSbXBFUi9pSU51VjdxWVgxNnZuYW5E?=
 =?utf-8?B?YVBGb25aQThMUW5qbUFTeHNDZ0k0NVNMcjZVeTFJWFN4aUxWZDFZSmw0dkxC?=
 =?utf-8?B?Zi9qMEQvQVhTOHZvUCs4ZWZkTnVnN29OQ0RJcTZjKzd1YWlTaWwwN3ZFS3E2?=
 =?utf-8?B?OHowMExDY0tBTkROZkRaN3VobUlwTlQ2dmcwUm5OM09FTWJHRlF6QWFQWkZa?=
 =?utf-8?B?TUcxanFtUFlmeWdGNEZoamowdFQ2Mk40KzhDUEwwOXZZUXFNb0FZVm9Tbjkr?=
 =?utf-8?B?T3dLNGU5ZHlmM0Z3bW5pc1c2SjdGVUhGTW85bVNDRzZzTzdUbW9ESm1hK2Fk?=
 =?utf-8?B?YXVvaGFnSXJpOW1DQldPaXhxRjN5dW5Ld2cxbWlONWVPSEJqSlZZTkpxNUJI?=
 =?utf-8?B?SXRENWV1MzJtSG4va0xwSHN0ei9jQ3FxcmcyVUt6UDB3YmxweEFxMEF3UE4x?=
 =?utf-8?B?bEVPdEN5SUZuTWpqN1R1NjkvTGY1NmZnSjdKeS8wK2krcGZoaG1ONC94emky?=
 =?utf-8?B?RjFaa2xiM1FyM0lhbEUrd1FiN3lmSEdEUUJLbTVhczg1YW1QMEpwRWtNYnk2?=
 =?utf-8?B?alFteXVWRjFEVzRHWmJXS3hVeEUrV3U0eU5aRURDRWFscmMvRCtGTysxTFlE?=
 =?utf-8?B?SFBObytZK200ajIwV05oaCtic1RKZmx5YzlUNFZGMVBGMjBDYndBaTFxcEh6?=
 =?utf-8?B?Tit6RTh2bm85TEpvSzRCcDh2bkQ4bHgvcUdGQTAyeFN0REZtOUVZRTZ0MXI3?=
 =?utf-8?B?UmpVZ2FEVlAyUXMvZ1NZejRoaTNMVzIyVXQrMjhkM3pxVVliREtmT3V3T3Bs?=
 =?utf-8?B?Vm96d1Fua0lHdnRMWTFwajdoaHo5UzJmVk5yNlV0UXYrMzBLVDZUN1MyMjAv?=
 =?utf-8?B?RzU1dFJXY3V2QktCN3oycUNNcmI0aDB6VXNEd210bjZsQlpJZDFwVC9KUysv?=
 =?utf-8?B?VFdxMnc5YmNwOTdETzlFVnBUU0F5R2c1TWYrdVRaZlAzZUJOZW5jSEtGaXcx?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QkRTR0RmS1FZV3RMT2pjY1krbUE4Z2pzNCt6ZWNwd05LRlBUaVhXSlM0ZW5E?=
 =?utf-8?B?NW5nbVdXMkIwemE3bVJ5a1ZQNVpoQno0REQrRFRjbktYV05HMUV5ZzhFNzdz?=
 =?utf-8?B?OHFhcytWeFU0YXZEek8yK1g5d2NBUXdtZE5BTTQ3bndGRUNYemhSTTYzYnp3?=
 =?utf-8?B?dllleGMvZ0wvRmV1aVNOM2hta3lUSUgwOVlQTWYvK09pQ2tnV2lreFdHZit6?=
 =?utf-8?B?MHpoTGRIYmtrTWM1aTY2ekdmSTJ0b2ZOUVhwTFgrSDAzMnNiMTYrbURGZ25a?=
 =?utf-8?B?UHpOQkdweURUK1RxUnRpOGtVd1llM3FnakpsdlY1cGZUbUsyMjlZaUlPVU9K?=
 =?utf-8?B?TWtmbkpvbE5aaDlPdDJ6NXY5Ukp0Qi9raEx6MVRNZTV4eHd0TC9qZDZvNnNN?=
 =?utf-8?B?RXBTL3prVkllRUliTVp1Z3J4K1VPMWVTb2RjdkIreXhMYXcrYnhBRFY0WXVM?=
 =?utf-8?B?NjUxRnJkUmRZZHczZDJwaGdaSUxRdW5XdURXcS90UkovSFduU1VxWHZsVlJL?=
 =?utf-8?B?VEdOTkhPZUZjazRDcXRLRmx3UkwvQWFyNnBucVhuYUF3SnNjRGFsbUZNbmZu?=
 =?utf-8?B?ZlI4bXY0bEpOOGg3R1R2dlRGNmsrNVh1WXFJTERJWFBaU1hIUm90K0VFQ0dm?=
 =?utf-8?B?VThvUStWcUdjT2NYY3pteEIwVWttZWh3eGZRb015UnRMeTU5TEFBMXNqSHF4?=
 =?utf-8?B?MUdUb2txZWVDUFdRdkdvNGFwSXJwalJ6UGxRUDM3MXRhWUhKOHpWdExIVXA3?=
 =?utf-8?B?TkM0Qi9NZ1NZdzlmYk1aTDRKYjlVSWZRODlobWttQmNWNUtUc1BFbFM0Lzl4?=
 =?utf-8?B?OTloWmYrVEtBTExvTGNicnB1OWpyNXNZY1BwbjFUTW10MXBZQlkwamlxdVR2?=
 =?utf-8?B?eEMrZjBOWWxicFNNWnliNGRMYjlveWhkU1lJWmNHYVpRdXc0UVBpU0pINTVl?=
 =?utf-8?B?NlhVRkZtRTRxTkJLbmR6ZXBzS284VnlwcEt0Y2syMHdJNlVSWUo1NnZsUlZu?=
 =?utf-8?B?Uk9FNy9iZzZxWlJERWllMGpQb00wNjBTeWZ3cXVxS3hlSEhjNVB1UVVJbUtj?=
 =?utf-8?B?QUNDWlY5WHgxMmNjSTJPejhYbDNjTVNqSnVBNFExN0p4TGpIOU5hTkR4dUZH?=
 =?utf-8?B?RkRoMHNXT3FpekcveG1NaGhkdGpQSUhQdndncTFVUWpOL2NuTmNSMFRpd05z?=
 =?utf-8?B?VDEvUE9PMDlXQUFURktudExjMnh0ZE14TU9DTUx4cXFzMHJMNFl3MnlJMW00?=
 =?utf-8?B?VWJHcDBzT0RrU2lGV050WHZKYnFtM0VCUlY4WmJsbEsyY0pPQjFxSS9GMUND?=
 =?utf-8?B?bklMcDkrMm5UUlVOaWJnbDJwdkRWTFMvZGl5azZVYXZRQXlLYzRkRXM0L2hO?=
 =?utf-8?B?WUFGcHlIYitReThBb1p0NzYxRm5NYWUzKzYrdFJNRjMxSDAvSEZWV1BCbDZn?=
 =?utf-8?B?TXA5Q3JSUjZUVWpQZERHOGk1TlFqR1JBUkFNTEMxOTZpa1pjQ0NPUHlka25a?=
 =?utf-8?B?UW1SK2kwak13b3NwS2NveC9NRm55ZVFvbmNhZEhHQ3ZoMXVLZlBoM1k1aUww?=
 =?utf-8?B?ajJudnlWZG5ReUVIQXVNbCsvWFgrcmtJR0lsR3VWcXRMcktaanVpcUdiODJs?=
 =?utf-8?B?MmlnVFp3OWh2K1h2K0ZGakNtdk1TaUMvYjhjMUdEa1NNNEVXZVhQSExFU2dn?=
 =?utf-8?B?VTZFdFpLeCtEeUFwZU82dHlkd1RzZytWOVVwc3g1c1lwZUN0eUpxTFJnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7a8616-96f3-4044-aeed-08daf31da7df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:16:32.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SoHmUdinOAotEHMmpXfqotyyOumSSsGIJ5hT1qFTx7FnAmpYntmqYx7o1lSj90af1GEJ1uOZgg1Kycgd8our7/OCdTlJAPCVURxHOOKvso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100095
X-Proofpoint-ORIG-GUID: bMo3MJ9Lc440LyvH7ibaSGcanoL_7dQF
X-Proofpoint-GUID: bMo3MJ9Lc440LyvH7ibaSGcanoL_7dQF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/01/2023 13:49, Jason Gunthorpe wrote:
> Can you also look at the dirty tracking stuff? I'd really like to see
> that done for the huawei vfio live migration driver
> 

He did look and provides comments based on his testing of the initial series
(IIUC from what we spoke at LPC). v2 should be simpler, though I am still
working it out the merging of unit tests into iommufd.

My plan once I post the v2 was to handover the SMMUv3 part back to Shameerali
given the fact he has hardware that has the feature and can iterate more
meaningfully than me.

	Joao
