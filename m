Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C5691DF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 12:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjBJLQZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 06:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjBJLQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 06:16:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523B9C;
        Fri, 10 Feb 2023 03:16:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAnNZP032242;
        Fri, 10 Feb 2023 11:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G3EYulyIGhn30xAv/6hc7fBStJUhwXrbjnYjPLryA/0=;
 b=h3iK/I9rfKTUT3wmBm2sG3dFW1J+o0e8f4K0u07wYi2J/2zk3mWBe77Ts3AYAp6Nz4/7
 EvQ4qyNlxFoso/11ABpJ0IkSuR3Lp+ahqCdjQiQt6lc/e9wp0auim7ISI7r0I3dhRMZs
 cSilJO9bvd6+BW5gFG3FcwsUnoX7nd7zDoSF7UB26ynUwL8Un92pk7UXoVimpn8XezDF
 gTIqVH2fF8Z60dKwiFUiji+d2/O33Vb1spPpKGPtsVkCcixOYEZTZX6246UGKvHwelZA
 HZ2WSS/K2xeyoayfKijwUWQsAx0XweTsPr3MwjVEfCrVJCFtfGzAqTnJoGhuQuvfEwjf Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdw06y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 11:10:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31A9JN49025785;
        Fri, 10 Feb 2023 11:10:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdth7byj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 11:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7IPXcNLSifsRFyCfs2rRaqC+fp/E5WCuQo5LAHR2vXM79PnsOWIWLbZzbxTIlO3sSYxX5yXpGbBIP6eZC50Czieo9P+2Qlpm90JwI6KLZiDmguaxTuQSHmwQSbRGh5+F4v3C9p0CAT9NvWEdwQKB08exsB3vLl70TIs1sInE/R1MxV0xBEOHYvljczZ040clc/mFfBiXT5k/lWPtFbvmOlqTANWOwX9AiJw4tpZE4u1bxfF4hKHqNvRxS+x+iubJcw7SzsQ74dAb+HvT8p3lHqreMLfpCSXFqAXibG74gcmj8MCMxVKAWUrLFYYgcg7vbMBGbP+3q/RrMd37VlShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3EYulyIGhn30xAv/6hc7fBStJUhwXrbjnYjPLryA/0=;
 b=Vswthf6qh35iWT/EDvR5UwRoAnGMX3uGJ5dUOURtm6xVPtfMySsZTl4jEWSwBO5xRXEucU/GNrTcCL9FDr+zdpQYYhcqRs+qRbw1OIm3sb3jM56+hW8Nwa2q0lDvYmnPGdq8+exo+VUEwj7XZnpJq2PVUMgpnceGxIBScBIEwn1vzZhHjEwbt6Sb7yj4OzbT9irJIwVm8RrQrUC7X1wdWI8uT5Ozunxq/BrXqTgERE3OVFCwDLJmKRkNntiKz1JfD5CqzwHgAoJpEFqYj1dEgT4pm9I/izCCIz95YxyhGcaMpANti9c6ZGkKhFVrZiHLKkzjiFXbarWwYP6LrdIl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3EYulyIGhn30xAv/6hc7fBStJUhwXrbjnYjPLryA/0=;
 b=XHtblWqksnzOevmUob//0BQZaXkhHGh3xJUR4uoixCaSDvupi5UZyEhhG/knmtSzOAWS5LEtv7Jy+kd/BJuQQyztkoWwnPWoaETcFo/bQZTY8f4C/HMQaS4Emn/6IfBx5Yv05bJSbfUtrlrjGOiiLnK5w0SMBbgJ2+VdzGygWPw=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 11:10:44 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::9b30:898b:e552:8823]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::9b30:898b:e552:8823%3]) with mapi id 15.20.6111.007; Fri, 10 Feb 2023
 11:10:44 +0000
Message-ID: <09349db9-8847-614e-4c8c-1b0a15119244@oracle.com>
Date:   Fri, 10 Feb 2023 11:10:34 +0000
Subject: Re: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-4-yi.l.liu@intel.com>
 <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::7) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: be4ef199-53ec-4966-582a-08db0b5773e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpH0WiuyJ76khznqcSnbDSEOr3gyCm0H699dDyB4ZC7pYikJEt9WO1dHyUv0sF710jPhDkuuvwYrWd5bSGNk3suAJ9PXrA8BgQbOKagq59CGu1zeZL9QhheJZ05GWgfWU363aqrsw18QgKmetXZ0yHe3oj6LSUM/m8f/WnvLwbU8b4/HyPpJZCYlxydbojO/mIK1iZBKHhxw0fDx3Nw8mYXFAg/aeTrGXxz4tzRketzDiv5GjH994U0LtS3l/JW5USAhMamPeuG9Na2yTDHbnDFsxK2qzwSpKkUcoyVCye75UoNSwaJVOL1ESfbLCRZlbZiCYQe3KfGL7tixOpgf/ymyClcAyWHYgZIB1ph0JI6uXxCcsQZiip70OB2sYG9oMuoCe9hSfWgexlReFGSBvZwwbxaAvS8gmLDQ61eI3u/0+zvsZaNS1pqmXcAiHk25T5NhY8HRIUYHP5dWAhIL6bh4/8e3O8EFcKbggBS13e0p7DcJQ4HXrHRCxwhbqQXkATNywGs9J3fuL+zcEJF7g+tUegvPenFQ8hhyScXVyUrtLYpTSNjRfMxOf6mFerRqq6HcKaJCK2JjhC5olt+aYWIadDHhpTOGQnZwckLqg1oTT5mhM8XjQz23m3yiMA3zdB4p4C2+o0lRNl+sIrTQd8zXd1EdadyHVQboQsDWpc5ww1xeHw/Urdrle/ClkEL6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(6506007)(53546011)(478600001)(6666004)(6512007)(26005)(2616005)(186003)(31686004)(5660300002)(6486002)(31696002)(86362001)(38100700002)(66556008)(7416002)(66476007)(36756003)(2906002)(54906003)(110136005)(316002)(8936002)(41300700001)(66946007)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW15RTlzUkVLYTVmbUJ6SzdHbjJmOU5iNkcvRFNWS0hJbWdNNWZ0bkdKdDVL?=
 =?utf-8?B?Vy9SdFdMcmY3a1NKRkhEYm55RmhjczVTdDBLanljQVYrV0szWnF5bVF2NklG?=
 =?utf-8?B?bnJsdEFSUW9hQ09NSVlxdDhmeUNnSmFvMkVHbHNtZVRlek55V2Q5dk5aa1Zx?=
 =?utf-8?B?ZmFuRG95YVlDTmVQV2FLbmtMRHVlWUVTSlFZbTJFRythRFF5TFJxR09nZ0pD?=
 =?utf-8?B?a2J1OURZelpCU3ZKZWN0UXdJTHZ6ajl1YjhoS2g3ak8rU0d5Wlg5YTdhalUy?=
 =?utf-8?B?U2tLRnR5aVhncDBnQ0EySktBby9Sb1k4cjNvU0RZckVoUHlUUnF5SUpiL29S?=
 =?utf-8?B?OFo2ZDlPSWNYaU1MOFdNOGZHeWVqYVhwRXFpRjVZWmdTa1A4a2NLNkdEd00y?=
 =?utf-8?B?SklWUzM4TEhCekdseHJiQW1NMk94RlRHSHhSYVRrRGdacXJUc25ScFRkaGFO?=
 =?utf-8?B?a1FaRmdCNDR3NFZ4ZHlSY08ySzZrR2tVMFRZSnZEeUJmMVkweks5SGJCNkg2?=
 =?utf-8?B?WnBHcllYREVwMXU2ZFpxNEtYYVAzeThHL08xdDdnV1lFY1NNMkcveXF1VFRo?=
 =?utf-8?B?eE9JSkpSZ3ZEeXkwUDl2SWhYUmEvUnVtMGlneHNZUlZESW5CS3MzZUVETE56?=
 =?utf-8?B?aUJieDJIcUt0OWNwenJZeXk4S3E2eC9FeGR3eisxcnYvWUx0ZllUMkZNejY0?=
 =?utf-8?B?WndqZTdadmN3NGp6em8vVGQwYzRBblJoaVN1Sm9waTh0NSsyUVIvQUk1blgy?=
 =?utf-8?B?bCt1V1VLaDUySkFsSk94YlNQWHc0ZHphWHRVMnhDWkIwRDR4bWEvOFk2N3N4?=
 =?utf-8?B?dW5WQ2NjK3QwZWZGRUdvNVhUUjB2dG9zYm8xUGswNmJ1OHU1bFJHRWtjTnFx?=
 =?utf-8?B?Tythc25FU244Q3VMMlI2TjBvZXFVZld0Y2k1UWJFZzF4U2NISlg0WUVPTjEz?=
 =?utf-8?B?anpzNWhnbDdPSWZsNS91MzNlY1BTLzlaSEg4RUhxVGNuVVFsZjZyUzdoMWds?=
 =?utf-8?B?Rk5wbVdQc202NXROTElPZXRoWUt2RDF4aXZKdTVDMHFrTXpwNWRUV3JCL2wx?=
 =?utf-8?B?Q3ZYTnNJbTFxOXpZVzVWeDJ3OFpwN0ZtRnZ6ZEpMekpxOUM0R0tGeGhsWXdF?=
 =?utf-8?B?c2k0TmRSMkZBYzdtZ0JyUkFSY0R2VVo1VzRIcWV6SWl5UzFXazhpYXlvdTVx?=
 =?utf-8?B?MklOdWd2MUtEN2I0b2dxcmI2Q0hIMXU0aGp2eEF5TU42TE1CM1VYZ0FHbWxT?=
 =?utf-8?B?R2E4VzR5R1JBclVWazZCb1Z1L0tveW5BT1NTQXgxN005dVRpZk9hcUNhZWxU?=
 =?utf-8?B?ZkhQOElraXdyVGI2aWJhbGRaYm03Tjl4REM1WHdyRndaMStUZEVFcGpMZjUz?=
 =?utf-8?B?QkVScjZ4aE5YTHdnS2tRYzcyNVZqMk9aQk1MYXJoOUpRQ2xkYmp1eUcwc1lL?=
 =?utf-8?B?MFpPSm5mNk9JeVEwYzRpZkJ0WHRKU3B0RjVDT0NoWmI2MEt3TWxyT3dKWkpR?=
 =?utf-8?B?ZEtIL08yOUFZN0FpT2Z5VzR0QVRYZ3M4bmswRy9MdUJMcllJYWZ1V3E2RUxE?=
 =?utf-8?B?d21oNTdPSDVVWGxyMmxpTnk1QjlQVlNmU1JXUVZ5R0ZVOFlsVjRQZmd1VnFY?=
 =?utf-8?B?T0VpaW9hRnIyWW9PYStnR04wZzg4TlJrTkdmK3Q3cmNLR1ViYjFLRHc1dzVm?=
 =?utf-8?B?OWN1WG1rZjJuMmc2bGtSNlcycEdtZHJ2eWtXcDMybHNiMkh6ak1lS2h1Y0gz?=
 =?utf-8?B?NTAybHZaenZFYXhuM2dXdXhBazNOekFDOHRUT3RNRGphYm1ZZlJoVklnWUVK?=
 =?utf-8?B?MTBxL1N5elBKbzNoQnc1U0VlUVorY2g0TmF4RENsaDEvR0xYbjJoMEZVN2xK?=
 =?utf-8?B?SjZQY2RvVnZpMVJzZXRlZ05xemZMdFY1bGZuS0lSVVUrN0gwYnAvbUd2K2xC?=
 =?utf-8?B?NFJ2REljeFVTOGFnOEdVUmNtT1J6bUFibG9jOHE2V0p4RCtvSjFPR0MrdnJv?=
 =?utf-8?B?UmJ5VWVaUk53V3BJK09iZ1dQeFZEYzdRY3htUHRPUTBYaVpIaXlzNkxFR3FC?=
 =?utf-8?B?ZEZ6S1ZGWitWUjBSVCtJMFhQV0poWnA1ODRPRmhadHVUZHlqdnAwaXE5bmpD?=
 =?utf-8?B?MElEb3o1WjM4cUx5SkRHY21EYnphbSsrclBVcmU4UWVEZW9JYXV4RUFqR2c4?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGdYcWU0LzRYNWZrNUVhOEcyMlBrdVdGOW85S0FjSTIxUzZnYzRUdUlzbGNO?=
 =?utf-8?B?aUlmMXhzWXU5U3dPVytBdkJoQlhxeTlhNm9sRmRGdEZRcGVqY3hpUG4rbitQ?=
 =?utf-8?B?R24xSXp4Ri9KcDI3ZU9adGRieExscktvUjdYKzRuWlpFcGtzL2JFVVRXMFkx?=
 =?utf-8?B?MnBuZktwQklDbGhaOWpqaVh6d2ZVVnFjeEdxQUg2Sm1FSzdOSjBLb1R5dzMv?=
 =?utf-8?B?alJxRTZoMVoxeGdjcE9lWFNiZkpmMS9YeVpxcTVaVS9NekowcEJXNncveElI?=
 =?utf-8?B?Y2x0Qy8rWGgzaDhHRUdSZ0RjSUVJVytGdG9SenV1dHRabnRJVjRtT2dWVW85?=
 =?utf-8?B?ZEZhdFpFemRGclN1Si8zS25hUlREV2xWdHVTVFI1ckhBNWd3L3BEQlo4ZVp6?=
 =?utf-8?B?V2k1Vk1nbkVUc2xTeEJUcXR6WElrUkFwSS9OT3RZcnE3YWprK3grMUxuYkVr?=
 =?utf-8?B?YktqbHZEektKQnJjWkxUZmhTVUIxQmdVMTZhQVlUY09hRE5mRUhMei9kZlhv?=
 =?utf-8?B?b0d3ekZSdk9ESzJtUVBPeE1wazRDMmlHK2xFZStSd2phWUo5aUxXZU5mc2F5?=
 =?utf-8?B?dnBMMDlWc2xpK0k0WXo1QlUxeHRZT2J6T3E3enE4cEl0UVdUVnozdE5KUzJl?=
 =?utf-8?B?QWU1SXVkRFk0aFE2WVlyZy9mY2FJdGQ0NFcwUENNaURrNDNLTVJVdjQ4S09k?=
 =?utf-8?B?TkkvT2FtRTUxdGxaTm4zWFB0N25ZSStuT3lXR0dKSnN0RWlORFlpYW03MVFU?=
 =?utf-8?B?Szc4ODdhWnB6VnZrTEJ3dlZlREdja1haZ0Z1TzRQZGpsYm9mdzNqMC9qMGdY?=
 =?utf-8?B?QUJ0aDI4OTliaW02dDRtamhEMm1vNDZUV2NSTUhnLys3UEdBT2Q5SENHaUFo?=
 =?utf-8?B?bDhOUTFSMkxPZFEvVVRackpyYVZMUmZEOWhteUFWTDVnZmFWZ0tFY2xnckNv?=
 =?utf-8?B?TVJaQ2EvMi9NQ1hlbllpaDhwK2kwdDVmUGFGTEp0NDBHR3JxY1JncW9PZ0RM?=
 =?utf-8?B?Rzk1elZOREhDdjlyTFpkOEF0MkZrNGR1Ykl5Mlk2WEo2ODBoeWNQZ1JXdHJW?=
 =?utf-8?B?S1ZYRkFWaFFldjJTU1I3dGpGMmR3K2pUUjlpVmlHSXFZVk44ZHUvVHdhOVVV?=
 =?utf-8?B?MnlqSTh0eHhDQUNtWlVnYzBPRFU5VFcyZUF4Vk1zUWVUcm5YUDRRQ05OWkkv?=
 =?utf-8?B?cmdsaG0rNjU3K1hMRVUxemRyQ3dSUDdHSEgwYTFzTFczWHFIVjBXNXBhTU5N?=
 =?utf-8?B?U0w0cW5IVHNsMlFFc2c3eDFydncrdU13K0RtSmVvTlVEQVlTak43a2phbWky?=
 =?utf-8?B?RXhaZ09rVXBwdEJ2WVVIQ0RialNDM1ZvOEU3eFBQS1Y2ZktEWFRhM2ZjcXBM?=
 =?utf-8?B?ZGdUK3JreGZ3QWdkZ0FxS1JZVUlwcDB0UmxoUW5NcWdQT2Vjb29lNXVKSnlH?=
 =?utf-8?Q?/dRI4QdY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4ef199-53ec-4966-582a-08db0b5773e0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 11:10:43.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v07gsK46oI9SMignR5ZMBHHcaDZHH7AOTp/RS6htAiw1C1nRh7B0645jVaQ59X2XlUgC7ofxTmZdm8BwFq8+IcuZkxnG85ql9j/sTcaClv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100094
X-Proofpoint-ORIG-GUID: a2-Hi8v5ya9ySckNxsl40PQhLb6TKRZp
X-Proofpoint-GUID: a2-Hi8v5ya9ySckNxsl40PQhLb6TKRZp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/02/2023 07:55, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>> + * zeroed if the user buffer is larger than the data kernel has.
>> + *
>> + * The type specific data would be used to sync capability between the
>> + * vIOMMU and the hardware IOMMU, also for the availabillity checking of
>> + * iommu hardware features like dirty page tracking in I/O page table.
> 
> It's fine to report format information related to stage-1 page table
> which userspace manages.
> 
> but IMHO this should not be an interface to report which capability is
> supported by iommufd. Having hardware supporting dirty bit 
> doesn't mean the underlying iommu driver provides necessary support
> to iommufd dirty tracking.
> 

+1

In fact this shouldn't really be a way to check any capability as we are dumping
straight away the IOMMU hardware registers. By dumping raw IOMMU hardware data,
forces the application to understand IOMMU hardware specific formats.  Maybe
that's OK for hw nesting as there's a lot of info you need to know for the
vIOMMU pgtables, pasid and etc so both are tightly coupled. But it is a bit
disconnected from what really the software (IOMMUFD) and driver can use, without
getting onto assumptions.

[Calling it IOMMU_DEVICE_GET_HW_INFO would be bit more obvious if you're not
asking IOMMUFD support]

For capability checking, I think this really should be returning capabilities
that both IOMMU driver supports ... and that IOMMUFD understands and marshalled
on a format of its own defined by IOMMUFD. Maybe using IOMMU_CAP or some other
thing within the kernel (now that's per-device), or even simpler. That's at
least had written initially for the dirty tracking series.
