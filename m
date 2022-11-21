Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA2632994
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKUQeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 11:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKUQdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 11:33:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4314D31;
        Mon, 21 Nov 2022 08:33:16 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALFAT0U018298;
        Mon, 21 Nov 2022 16:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=N8CDm5z8oLzgvfyu2gURRrBS8nLOHiNAW0Ui8jRZEc4=;
 b=PEALuEk4RBHpOcGUfYJmEKmaoFFyA7W3IV6dajOk9t2FNk4sGPwYuWyKw8YWGsYzHGRP
 GH0Xg2QJrM6E9M9K15ChpKLgw6hLo54Ll+YloKKDnzFYpajiAW6sjKKOYLu6E3QAizUB
 k1YvhiufKQ5XzqZzlA3+6Af7x8G+4oA3z47jTH2ATmnuxpik24mJl+hurhvxPMs/ecje
 JoaFtVqqgvLI3tg5H77V8WmuBAzKX2J32kZJxt0XK07hqcRck4eoGdP3xzjpr3KGaS3U
 0E/tPF9JMXLfNkO+FVAcsxjeAfe++BoW3I4y9uw9wEqOsI9WvmQUZ6xrAtKf1TvHFH3K BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfavyaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFeBtl039705;
        Mon, 21 Nov 2022 16:33:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnka8e7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eijt/vXXm3IitIkJqw/XeL/Fjso2QGIr8KO4liSWvrW4zfMK7Uk2GCNecNZj00W/783tzkqXoEY0SpuFh2g0yM4FQkEZgvh5QcpXotdcV+eyVLXyOLfUgkOkC3uJqKQeLmcTXmGlFk6sVAP+hMw9/IeDKpEWSmEVyK0+jhRXxeUUCnHDAAelmoHcSNM0U3/Z0ZSA0Jse0JB0B3AxbT678ghhxUFhdxZpw0amjP9knqQu2M/cVfary++ylOuAwF6C7rolQn6AvhX/nJD8fddQXSrmwAYMA2RurgyLfOuWTqjN8D1JAzmMJVQmqeS6my7RF+/GCyzhrywH1hAXfxw8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8CDm5z8oLzgvfyu2gURRrBS8nLOHiNAW0Ui8jRZEc4=;
 b=HD2ZqFZSULT6JRPTCfKkFQFNUldMOMmlY1kiu2E+/bwweLVxey/P5tw3zPmD4SqjzkB+ZvupcW8EYlFBeM4Xdv4wE4+jP2lsIKqMZC/qu4NWVz+/PgyEtZn1GDKL7y8yH5n/h2slGkb/EmlaYQM/9xJJq/2kW3nrgucpbVcB5nntU8ofRm9eTKqsg1jcqwoVOkjQNPdWT7MVgPtZiQ4g1Grb0c+xMPZQwea8NounFwqR60nCPKTHWy95pyEuLivAFx5FGYMSxRpziUh53I+348mDfIFeqKncK0qgMy3GAvoQGdNmRTlLV8GGLUX4Hen+i1vv9f6rV0vbzj5N9voDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8CDm5z8oLzgvfyu2gURRrBS8nLOHiNAW0Ui8jRZEc4=;
 b=QVYzIjvNNSCxVHmZvQVFFE6DLh7Jj50au/MowFZbD8TC7Qeh9/JXJxbqGcY85iQKnUcZsuLnvD07v1qx7hd7/A39qd1IhGqDF/U6KP9eyTkzYZfnlGzbg7SYNOLAZ2WJkrnnFdjnwQjGaB2l/RPtSUPL5NbYbh5xvZnf1/4GjJQ=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:33:00 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c13d:dad:6a35:b25a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:33:00 +0000
Message-ID: <cdaad6d1-ecbd-3afe-5f34-0669a136e62c@oracle.com>
Date:   Mon, 21 Nov 2022 16:32:53 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
From:   Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v2 5/9] KVM: selftests: move idt_entry to header
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
        David Matlack <dmatlack@google.com>,
        Liam Merwick <liam.merwick@oracle.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
 <20221103141351.50662-6-mlevitsk@redhat.com>
Content-Language: en-US
In-Reply-To: <20221103141351.50662-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fac26d-f88d-42f8-5a75-08dacbde0deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tcikFjgpFxw+mak4qA5M53b2sM8ty1uwcsg76QC1wOhNU8QBPJqpKJeLkpPyFL9F+USwv3m196vNY8fQuHewJ+V4n3J1mBYWySwqytKkyB8317FjIekSYFea+roEz2Du04D879NzawkWXiGFoaIYZ/Ahl5cqPBtq9dAmy55o0yCSkLz3loR9TlQockyiExEq6YwE7hxIcr+J/MQXVSy0vKx6DjBPNItXuE0SJd2QZuxludIl5D44T2izhlNw3bEq3A2j32YefI7vNb1hiB5LxsCk/7rhmeF6xYzLxYgNyjQt3y7Y20XAL2f9dsAV8S5KMNSoBnsBo8VbuDXXPH0n7enpiWlyxauIcZwb7eGCrPWFHrysxRcUTBBlMJt3B3907SP4dcW3EfO11SSQQ1+8eJNcmVtIQj6Jgsm+ME6eTesk6mN7O6cspshwxTPyH4LovP9LKxP8H/XkmpJP8hTCefgrIstcDtgi1DBvkECUsfWPTs4Y7ECUslu4KH79A2OeYIipUhyDZ5fLw5eTFdd+owujFDH+Amji0RMhhMsiR4qJU8Q5qb0nPqBiJmU5HCdCJCW5qOfwaGEXJm0qGsMaBwSjQBFRo5S+Hps9CImUJRKvtNwTHBnNyn6Keh6MXApFA62kAR7YZbgNRzfvRJYk5IahvUw2ooXeVZjSoAoklFxapnp2RF+DbeJiGDXbAgjXPwwWzD4kI3v1Likm/WGfxtGY0kMKYf+lqfoHaaNoS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(31686004)(6506007)(2616005)(66946007)(66556008)(41300700001)(36756003)(31696002)(86362001)(54906003)(38100700002)(83380400001)(53546011)(4326008)(186003)(8936002)(7416002)(44832011)(66476007)(8676002)(5660300002)(107886003)(26005)(6512007)(478600001)(316002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ry9ySTRObWZPMGszU1dIV0dITXhISjl5VFVIbW5nenRmZEpsb20xVnlSQVE5?=
 =?utf-8?B?RmNqb3NKenZzaEw4L2lTbjdmeWlhTHFuNjBJOHAwODJhcFNnWUhpeTFsOHV1?=
 =?utf-8?B?RVV5T0c2ZmgwOTUzTFpyUTFKc2tCcjlHR1AwaWZSUFl4bmNUTXprRU5naHNC?=
 =?utf-8?B?eWJldVNCYjkwdUg5RnZuQitqWmoxUDhHd2VIbUk3S09NSkQrVUl6OUNKMkZv?=
 =?utf-8?B?aUFQbXFZQ042YzhQbm9Ea05YSjhSeXFiL0hDOWVoQTdoeG1BTHZ3dVI1U0V5?=
 =?utf-8?B?K2RLWjE2NnpGNEs5YVZXMk9meXZ0aFY4WnNTSDd4NXZjY0IrVkczQ0tpS2E2?=
 =?utf-8?B?ZGVqYUdLZHVoa1pxTGk3NXZzM24xSENIZ0o0ZUNVWjV2eFRjZXFoZ0p5ZDNw?=
 =?utf-8?B?ZGlRbVEwZkZoV3llNUZ5eUZmU0tDRktFaWR3dTVLQTg3aklSVHljcWlRSGpH?=
 =?utf-8?B?ZGl6emd4L05RbEtlZmM3YzdCbzhqdUdRdlZ1Vkdtb0dkTmF4NFcxZTI2WFFn?=
 =?utf-8?B?U0hFWEFDaSsrVzV4TVVDYklyVFNrVG5PL1JoL1FpUmcxZERreURZZnhCRUc0?=
 =?utf-8?B?Y2xpRkpNZG94Ry9aK0lxbXhoeWVvVFMyVDZJT1dUT3ZZMXBpRU5QdWZYZTg3?=
 =?utf-8?B?RFFtU3oyS044YmZvT0NRMlFvNnpXZkQyaWhvYTVGcGRJZnc3SndoeWlTMStv?=
 =?utf-8?B?aGhhaGpPR3Q1c1NVUm9USmYwM2MwTUJlRzRuck9NWTRnNFVoRFNVem43T2VS?=
 =?utf-8?B?eEJBWG9FaVBOYm1IVitlZ3hUemp1TFdWakRpanlmUXd6ZVNTMXFOOUw1cjRE?=
 =?utf-8?B?U3Z6WVFJcEtpTnVIK3VwaXk1cm9XaEl5SXFzYzVDNkV6RXNkVTlzZ2FUM3FB?=
 =?utf-8?B?MnZ6MDNBTlN0WVBEZ0FvZzlZU2o2MXdYbFpybzdUaDRJK2ZuWEdnZ0RYa2hu?=
 =?utf-8?B?eS8yWUkrMGRxaHM2S2h5WVJYN3pDck1xbEpNSnhXRGVJQkNBeDR3d3o1dmR2?=
 =?utf-8?B?RFZVRU1uOC9RZ2FaRDgwanp6TFZ2MlRkSzJFSUJ4MkpkK0hDdWI2Y0JHcWp0?=
 =?utf-8?B?WFhZdmxoQVZBcFhvRHRtQXJrVE11cFdNNlVpUzlvL2NlM0p0dElSZmpUZXE2?=
 =?utf-8?B?TTZybkpWVENXOUR2M2VoUFhyU2hCMXllTGg5YWFlOWcxVWQrc2VKOXFnRmRB?=
 =?utf-8?B?Y1VSWE8wZGhXR1k3VWl2YmZzUWFESk05cy9BeW1ENzVIU1hWelYyYVNLZWRn?=
 =?utf-8?B?YWVKc2JDWlg0N0M3d280NENJZW1rQ2pxRHppc295bDNqNGprWERuQmR2Z2lw?=
 =?utf-8?B?QjBXN3N0TUI5SFE1ZjhKWHRGTUJ4azY2ZWR6UjVML0xYMjVDUy9iUFpVT25u?=
 =?utf-8?B?eUk3N2oyUnAxeVlUbmpUU1dEclNiTm5tZThxTXZqaWNUQXhUUklJNTlnT2dM?=
 =?utf-8?B?MDVjMTF5TSsxaVUrSzRUQmZ6MmtzbHNheVBsd0Q3UENyeDR2UkxqUCtvWEUx?=
 =?utf-8?B?OGVzTEp1TWczVzEyRk5WTWxmN1R3VTZINE5TaEFQQzIwOGpZemNMK3FhaXJU?=
 =?utf-8?B?ZFE1aENWWVJLZnRqZmdoTnBvTDFGNmZzRnpsNzd1amw3NTAxanZhcFJxYTk2?=
 =?utf-8?B?ZkxhdG1jWXV5bmhiZ2tFQTZWcVNrTlVlTTVDRHRIMzBtUXd1T1psN2pmMTJw?=
 =?utf-8?B?UGdoQi81cGtkU3NVb2UySC9uRDVlNjFhdkFDVWdDMW82OEwzMHE1K1puZkRv?=
 =?utf-8?B?dDB5LzZYOGFPWUdqQlpLYkxtWUpuMlgvbHpxNDdRQ0x3VXgvekhHSUhEcnRB?=
 =?utf-8?B?SkdtK0hyWUNwSU1OQVJ4dEV4MWtJMkIxVVcxTnM5NFBYcittbFFKdW9Pa0Qy?=
 =?utf-8?B?bDVIYjFjL05hWmVvdzNYUTNVZWxpdUFRNmdEMlNpdUIrQnZZV0gyZDBIMWds?=
 =?utf-8?B?RVNjQ0pBdHE2VXBsejhnc25hVmplRkJpZkpBM3pwYVMwTXRjZTMxdUZHWXV0?=
 =?utf-8?B?UE1wTlBtL3lvWU41MXRheEYzR1QzdGFlNDRXQmR5UlRnZENrTDhiQXVGc1Bt?=
 =?utf-8?B?WUg2cGNQV3hjSDBlaHRUUmJQMlJ2bjQ0SUoycjlQaFhMTFpFZ3ErRGlkU1No?=
 =?utf-8?Q?IMQP5J21+IsgqwlD0IoPJKHck?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VFdBS3ZSOU9CZGlKUDdVZjFUd3Q2RmhCVk1Fc2ZSenJGVVB2TDlXanptNnJH?=
 =?utf-8?B?YW1HcVc1QmJidVlTWDBFM1YyeE0vcy9hQWZDWEE1NGVHeTB0VjZ6ak5mSnpj?=
 =?utf-8?B?ajR0K0d0VEwwZjlyQ1gyVUhYeGUrVi9UTFlFbUZIUmZja05rUUFqQkdPNWJV?=
 =?utf-8?B?ZDBBNUpyWG1CZW1id0lLV1RGUzFWUk94Z0ZaUGt6K1J3bThzZFJYemVBU0ls?=
 =?utf-8?B?ZERSWW45VjNXNDhwcmJDV3pjbTB6YzBDdnZMZ3kzZjVSM3R2Yy8vQUc5ci9q?=
 =?utf-8?B?ODhzZmJaeXZTd2FTZGNHZExjTFJlaXZRUlhZMWdGbG54bmkwRFhwK1BZUkUw?=
 =?utf-8?B?ejQrcTlvWnJYQ0VDN3QwMndwWnV4SHhDZTZiUnJ2M01zZG81b2RtZDRPbExX?=
 =?utf-8?B?WS93N2lmOVB1dk1TM2habUN0TGV6Q21SVVNxVFAwVS95eUVONTBiRUZyWEl0?=
 =?utf-8?B?Uk1aVHUydjkyRHJxU3c2anlnOVF0YmFPc0FYbHNJb0dJVTc1VWw1aFBYWnlL?=
 =?utf-8?B?L0h2dDZhSkdYam5ZeUxHSWdLalBmVmZ2M21rMnhLaUVrdmFvUVdtZDU1aU54?=
 =?utf-8?B?NVAyM1dkLzhQT2lOckVwMC9XcGtmRmVHR0w3dU5ZRmpDQW02UFFmTUVrOVVL?=
 =?utf-8?B?VXRSVmVOcVhkNEVaMU43QWVJcUpGMkhUSFFlU1lSU0Uzc1R6N1JHaDVBTzRo?=
 =?utf-8?B?Y2R4QTFUL1AyeVZkanR0aGtrVUpzeW56Y3hOYTBNMkU5ZkZ5K0ZYZUtSeGo1?=
 =?utf-8?B?WHdQcGkweGJGWm9ZeUprNWFGWE5RYkpUeGV4QmRINldpMEZnMk50Z2t6dzdj?=
 =?utf-8?B?RnZWWlFmdjkxcjdRcjY2M2t4TGJVcHpscTNZbzk1YTFJejRiOEw0NUxzTGhK?=
 =?utf-8?B?RG9CQWdPLzBqQ1JEakJjUFZFQ3U0Q3BmQnFGVzZONlkzZ2xOTlpWQ2RmMldv?=
 =?utf-8?B?aitLajdqSzRGWjlhVEIvSElVQ2RTNnhGclVRY2gyYkY4dEJINnppRlp3MEJB?=
 =?utf-8?B?QWc4dzV3ZjFRdm45dUh1bkdZMG44WTBjVnlNZU5XNDFKM1QrQko1TmgzM0xk?=
 =?utf-8?B?ZGpjUCtwTlhlSWMvdkh0K1JPY1FrSVJXYWsydHkxVXpKVndVbmtXNEl6ZHZ1?=
 =?utf-8?B?N3dQQ0NiZmV6SlFJL3BnbzYyOHdJWXNIT3c0R1ZudkN5RmM1aEFvRjhoSFNI?=
 =?utf-8?B?UTVPaXBJOXZaam9VL2ZjVHF6ZkJYQ3dFSTI0UWowOWhJQkdFSFlwZHRKeEZo?=
 =?utf-8?B?dUNhYXVaRWdRNWs3ZXFDL3dUSTc0bHpvdTVOWXBaTFlFNFhzSFJPSkFGVzBE?=
 =?utf-8?B?Z2dzTjhDSnJlVUFyUHlYcndtR0J6Q1o5ejg5R3F3eE9EZ01odHdIM1NZZk81?=
 =?utf-8?B?MkpxUzZqc3JvdUZYSTZWMmlON3Rwem9KektJY0RvektwQ2VSUzJZOFAxMVJ6?=
 =?utf-8?B?OUx2d3dVUzZ4TFlVTDE0Z3ZWMWh1SW9JWHRKci9qbjJMUTFGM2lHTE1CWmJB?=
 =?utf-8?B?OHFsUEN5bDlFZVk1cFEzQkg5bUUwSUs3Q2l3d1dQWm1kVzVONzJJYkZiMHZX?=
 =?utf-8?B?TTE4S1g2N25qK1hOMzVnWVU4WDNLWVVzWDJmUkYxVFI0djB6Y2REWVcvTTYw?=
 =?utf-8?B?aE1rWEEyaVI0ZVVJeFdrNFRncHhmZzVVVElxbjh3M000alJOUlU1YlY3QjJm?=
 =?utf-8?B?MnNNTWg3ZUNDVnJGckViZVR2ajN4c0dLT1J1dXJKcGFiR2dlM2JsOUZpa09B?=
 =?utf-8?B?RSt5aFVXSDhvd2FiNEdzd0tMOXlPaUdVZ2pFN01zSkpiN25VWE1ZTStSdFFH?=
 =?utf-8?Q?t0u9/UQA+U4kkq1n5oHdbSdb1d8rd3fF4KxYI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fac26d-f88d-42f8-5a75-08dacbde0deb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:33:00.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTKv31sm62ebiqP5ripdIBsH3aq/MRWqJOHZowCTNEbYe/nvOzoSbeK/uIvi2nHbMdAapYBEyHBG5evhqLxAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210128
X-Proofpoint-GUID: cDVU-sYpYSFi8Oy3ODYexZcQ5X4bLI9S
X-Proofpoint-ORIG-GUID: cDVU-sYpYSFi8Oy3ODYexZcQ5X4bLI9S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/11/2022 14:13, Maxim Levitsky wrote:
> struct idt_entry will be used for a test which will break IDT on purpose.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   .../selftests/kvm/include/x86_64/processor.h        | 13 +++++++++++++
>   tools/testing/selftests/kvm/lib/x86_64/processor.c  | 13 -------------
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index e8ca0d8a6a7e0a..5da0c5e2a7afc4 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -748,6 +748,19 @@ struct ex_regs {
>   	uint64_t rflags;
>   };
>   
> +struct idt_entry {
> +	uint16_t offset0;
> +	uint16_t selector;
> +	uint16_t ist : 3;
> +	uint16_t : 5;
> +	uint16_t type : 4;
> +	uint16_t : 1;
> +	uint16_t dpl : 2;
> +	uint16_t p : 1;
> +	uint16_t offset1;
> +	uint32_t offset2; uint32_t reserved;
> +};
> +
>   void vm_init_descriptor_tables(struct kvm_vm *vm);
>   void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
>   void vm_install_exception_handler(struct kvm_vm *vm, int vector,
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 39c4409ef56a6a..41c1c73c464d48 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1074,19 +1074,6 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>   	}
>   }
>   
> -struct idt_entry {
> -	uint16_t offset0;
> -	uint16_t selector;
> -	uint16_t ist : 3;
> -	uint16_t : 5;
> -	uint16_t type : 4;
> -	uint16_t : 1;
> -	uint16_t dpl : 2;
> -	uint16_t p : 1;
> -	uint16_t offset1;
> -	uint32_t offset2; uint32_t reserved;
> -};
> -
>   static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
>   			  int dpl, unsigned short selector)
>   {

