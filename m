Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB57D571C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjJXP60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjJXP6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:58:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C310DE;
        Tue, 24 Oct 2023 08:58:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJaeq014328;
        Tue, 24 Oct 2023 15:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b8lZ6Z31zikT4IneJx6P4w0wd70rIvyfPczMHZi1Syk=;
 b=HfQ7NcMU9tz1IXpPsDADdGUw3hDJFY0bzV5k2xXHfkDVsK9ur+vcpjlo69hSdqYneiEu
 fTRDbs97vCsvz3jsFasxutRyV0k9Z1wc1w0az7gRHObEKFUp7vUg2N0RdlD51Idl0iwq
 +IhikBNYDy8XCDX3rVQHXrILKxVEb1Sh0oiHsV9W4nNhLsDF/BpF9GxB1B2PrXZJwKmh
 0xIQTqPnHIE1J3RqYoae3XB82Y+GjIkgdC0qWEmyUuntHf7kQpmPlXifXy+b+PS0AY5P
 PKq6pXyCiqx10vT83/BlnYFbV6YissajBURoNXK0MnBoF3JlpiNnSguF00ToZ3LWr5BN 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcwt8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 15:57:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OFkrat034624;
        Tue, 24 Oct 2023 15:57:01 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv535dxbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 15:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoc0n5eJcqCApGFxBUIbZFX/agCN3vQBqeqpk2xMbyLO4MZDGA9GkK8qCftHy9w+0rcnOMccHN+ix17Zqhul00gwbCVbcKuRYAJfXW48Gi6SdAeY+6aZ28hPZ+DJSY2cxTbW6Mur8WL2YRoAXe+wNX5QnaBhDghApCUYFvyvAEp7FI9iP4CUuYk2Xv02SmuA00TDKWSOAh8diEbOpbnCSBhEaX+uQpkRIJugtwN91yd+XDEBzzVgUYvUUmgosbzNFjw2+LlHqCyCYzOAJmYC5SYC052NG2QPOmOhVY3Fx3DtX0gUT3imj4uJ2O6MheD+2o0Gg4vccBCMXC0I8mdGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8lZ6Z31zikT4IneJx6P4w0wd70rIvyfPczMHZi1Syk=;
 b=LLyOgsyFncBpMOWaEugT4sN5RmVcsp7oPVXS1n/zSZYYZTJT0bcsMEj3+7lBYisQ8549I2JSK/JSrFhievrtNlJcU6IDAsShz20guPwXgfWZBWAwwZHABRqWMnX01fMLEYK2DTyr9oOjKJvyYpZfXsjW4Rd0IrsPyG8jKnqQaam85rKoRC6eJT2BVUKkMRVicu2vDxYFsZXSJ5csp4ub0PlfVnjbpID4tWMuEe6TfuVtsVJwar7bhSJGgJGliJP8a7sVoq+ZPF5lQ48SIOZoNP0mvkh1xtNhYqvFAK1WfdGS+FI6Gan4FDg8yQERx7WmriidQh7bO5YvGZ70nixoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8lZ6Z31zikT4IneJx6P4w0wd70rIvyfPczMHZi1Syk=;
 b=pW6v5VamA8fLnC+Qdcj6y4x/s7kFLR4yi6Ju1nvcTcyBEwt/fYojfArAt1IA5MZfs0Oh036IaKrDxW7fdMpZLPvtp5RQ7grQbhZhvqxGQB3k8T6GS+IPr5yM9Vrq8f6CO3w0WybCMTbdRuUigIo+b44p6Z1KUvA9XJnA7hUBHv0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW6PR10MB7687.namprd10.prod.outlook.com (2603:10b6:303:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 15:56:59 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 15:56:59 +0000
Message-ID: <b6b3bfca-f140-4ff1-86c5-69a302e5bfa0@oracle.com>
Date:   Tue, 24 Oct 2023 16:56:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] iommu: Pass in parent domain with user_data to
 domain_alloc_user op
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        jgg@nvidia.com, robin.murphy@arm.com
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-3-yi.l.liu@intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231024150609.46884-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW6PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: d394f2b7-7c87-4546-e726-08dbd4a9db03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8lExECETzGBZHGGHoG6QnK5ABKb37QHohWX9hvEnONWgQ3dHg4HduTtv0mFNqkz2BBRg/ML3oIZdNhc8hiWOSvYc0/FGxo/MpA5QVhQ5GoyetQdnY1lvfPjTNWPfVbmW2xdfX1yy2vs5z3S14DlgcGVIvLHu3+d8GDWeXnmNl3Wle5+o1275dQwrLnuaKV2gH4whNSRMcalIJFkR0PcBC6nPEx4r712YaBnw2W9zpalV3DpelDsK0A/7AnZhI581M4AO7VTRKC08PiP/hIR9Oasmp+RhORkOLq3lwNrD/5LLeWFQqmGYjcEp1OmZV4GIIS4VFe5/hup1qxMwnW0iGaLaodaqclwipMDsBlXQk2xoYYztympQswj4xRQakkbF4ved9FyqMWaA+jGbrNDmDUvbTV2oIxel/mjEBHA54DcLXDULBBL47gPzQ6bAqGOzze07us1E2B1O7pYZfQv56ZdlS5KNcaYARSDPCNRbwkCs7mINd6RB8d9orW3Lrz9j8oiud9q+qk32V1p7MR3ecaLAwQJdPAuENDg0E/am/JHl+eh0LC8WMuxbKb1RmLXHY0q1+sAvhtyDwrToJPK3S1qQ0fC1kBXWt8AQFVn55kAUW/8Bghx2DL3qKeAwO3d+Arksus25MMF4tfnI8VVrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(6506007)(6666004)(53546011)(478600001)(6486002)(66556008)(66476007)(316002)(66946007)(6916009)(31686004)(26005)(38100700002)(31696002)(36756003)(2616005)(86362001)(8676002)(8936002)(4326008)(41300700001)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJGY1p1M3FxUElRVjhoUmI3MnNUT1dTWVJLMWovcFZlYW40c1lWOUFWN3NL?=
 =?utf-8?B?SlVBTkZxZFo0Z3FYZ1UrdnNCYUY0NU4xd2dzbUpaSFlQczVLanpYVk52YXNk?=
 =?utf-8?B?bmJtV1J1UzVYbUJCK2NWMXV6SUo5a3p4bVo2N2c4Tmd4SnBYZHFMMjdUakdM?=
 =?utf-8?B?U3NZb3ZEM1VMT20xSFNkQ2hCYVFoZkptRnA0Zmt5dHgvYXlEUkhyY2RoUFow?=
 =?utf-8?B?NWFsa0sxTjZlcDhRN3pXZHZFTlRmWGp2R0FDWVkwRmdtOXJPY0lwZ3drUEcr?=
 =?utf-8?B?SFQvcUUxYnBDMXg2bWlZRFNoanFKZHdVbjNaZVNZWHFPTHJVY0VxMDdXMmVF?=
 =?utf-8?B?aCtQdUVQYjhueWF6d0lFSkdtZndJeGdjTUxpRnBIcThKbUhXaTV0dzdubGpz?=
 =?utf-8?B?akdUb09GZUJEb0VXZjlsYU5zTWZkWTN6QU9CVk0vUEwxMVpUSzJkYXlFVEdh?=
 =?utf-8?B?ZFRVdmFnU05CNlV1TURmc1JGY3VTaHcydFdoVkRndXBEVFQyMEpZR0wvbmc0?=
 =?utf-8?B?bjM0dDVPUGxka2tRRVFYQU9JbzJ3MnVucTdtOUFHaGJXWGpVRjUxTDVrRG9W?=
 =?utf-8?B?WUFmL1lYUmw3cFdyem9SMUI1b2I1UkhjazBoMTdGSWxFMXlSWFY2cERHek9s?=
 =?utf-8?B?YXBscDFZRXVCOXY2blVWeWorT3lJNGpBa0pTTHo1bjZHVW43Vkczb0RScjJs?=
 =?utf-8?B?T2dMOHhSa2xRNlIzeXl4VDZkVjZMUDVHbTR5MlNoUlpDL2NMbDV5b0FuNW1L?=
 =?utf-8?B?eUV1VjN3OCtTVkZLQW5pdVdSVXdlalN6aEtaL0dESVFxYUJQd0tWdUFaMndy?=
 =?utf-8?B?UnZqbzZQT2RCZlBGdE4vU3ZMVnVxaHdOWVBia1UzTktlWC9COCtOQTkzM3J5?=
 =?utf-8?B?dmF2eEtrTCtpQlNRdnZ6U3NnVHVIUm0yOThTSmNFMFFVYVRrYitSc1I2L3c1?=
 =?utf-8?B?aVZDNGE1YzFTYkFqcGFUOHhVbTlVUXB4RnF3cHNIOStmT09WdzkrRXZqTTBZ?=
 =?utf-8?B?d1RQRlgzanhPMU15MUlROGp5RmpqYk8yeDAvcWQyaWU3TGpuYjNYd2pnZ01D?=
 =?utf-8?B?YVhYVFdIQ0ZUMFJBZFpOS0w5N0FmVnFVVFFmNzZacGlZZjhZRWdCeXFWRmR1?=
 =?utf-8?B?NG1La3BYbU1LMWpCaDdpdnZ1L2pteWR0UHVBeVF1UmpjWllzMjF3SXRTM3Z6?=
 =?utf-8?B?OFRxV3IrU0dMdU9tcDBDY3hJbDkvMzVaQW93bWRubGp5dmgxOEJsOVlaNHh0?=
 =?utf-8?B?ZC9peFFKV1JEenRITFJCaVNqUHg0a1lrUGRJK1hIMCtFbFRNWnltd241MTZY?=
 =?utf-8?B?elZxeU9reXhkR21GMkprQktWUE4rbFJwNmpaTGQ2d1dNSmQwSEN5dGNNVVdR?=
 =?utf-8?B?UVdtQ0cxMWp0WG9ZWTkvKzQwMlppQXNPVElnR0lzOUd1bEZ4M1hCK082WCtI?=
 =?utf-8?B?ZkpVTW15MTlubEFpd3dOY0JTcWdGcWt5OFZDL0Fnd0ZJOWNCVnFGMWhxSCtX?=
 =?utf-8?B?b1gyeGFUOXdsZVlidkhuV2xTTGw2TnhVZWxnUTluOWdOUjZVQnJvczBGRERt?=
 =?utf-8?B?eVByS2FscXJuOHNFd29NMUVNcHdzT0N2cU1DMGtuUkJtcWVTUEt0N216K29H?=
 =?utf-8?B?dUhSMysydFRPZ3hWUXZVck15b0Nkd0FtL0tFb3dJSWpIQi9PbGNQaE9YdXYx?=
 =?utf-8?B?dTFPZ0p4R2NTL1NmcVk0eFpVcVBvRjEralhGK1lKTExWL1VDS1pmYTdEY09K?=
 =?utf-8?B?NGtPRE1nTGdLZWRMRnpXNkVGQXVROGpTQUxFK1VoaUVXSjlrRGlwSWFnWmpQ?=
 =?utf-8?B?WnBiQmVkWExGOXcycGd5cFZ6UzZycmFOaXN4L012YjJYYk9pcWQ4VWJZTGFF?=
 =?utf-8?B?cnVIWVNKN2lVWlhUSTZsbSs0bmlIWFlSaEJRam1wbHp4eDJUVUFTaXp3aVVo?=
 =?utf-8?B?OW8xU1R6RU1xTGNCQ3d6L205OXMwWUEzMEd6T0RIVXFlYWM5QzA1aEVFZUJ0?=
 =?utf-8?B?Z3BVejVGY2lTTzRuQVBhSHd1cGtadWU3M1FIazduZ3E1N1JKYjRsVy9EeGhP?=
 =?utf-8?B?RmhJamFqV3BQNjdYWVZXYUdIdDFuTXY0YVJnN0Jpd0F6OXZLQ2M1UVJrRmFv?=
 =?utf-8?B?T3NYOEEzT1FaQWIvbGtmMzllSUQyenZLamMxRDgvRlJuR2RHaWVrQW96dHll?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WDA3N3NyOGxPU1FkMWUwMzd1SUVrc01vQTkyVm11U2d2RXpURVhlcnlkRGlj?=
 =?utf-8?B?RHlJSHZjSGxkVEsrVU5hbUtvTGJ3QUlYclBVMGFNMGFzZlJTMTIxVEZUenZ5?=
 =?utf-8?B?MXk5REZmMkVkUjRrOGh0OU1YelljU2YrTmxJbmVsbTJmVFRZaDlDOExrd1J1?=
 =?utf-8?B?R1FZYTdnQmhDOVN2UG1vN0czMm9IZW5ZSDVRajRRRXUzdktDQUNZNVJqaFJT?=
 =?utf-8?B?aVRVWGIwVGh6UUFtRWNxK3plTjJHVVJQcDloQS9RdWw2Q2xuZ0NKaG43NXFS?=
 =?utf-8?B?OGxuMGdXZkx2Tk1EQ1VLdzBuaG80d2hwZUphbGxPbjMvcTNEem9CZDBLbndE?=
 =?utf-8?B?UkVpcWdkYjI3U3NDN1NtVm5pQ3I0QmxqL0lDei9FRVdqMTF5MEYxME95YkNs?=
 =?utf-8?B?NG1hcDgyN1ZuTnEycENBbVUrL2lGQXJySS9WWXlRVDJkV2x5dEpUT2t1a0dT?=
 =?utf-8?B?NXlyRkFDRFdnb2JTR1RRaDRxT0VtWjgvcW1QNGRrcmVHc3RyUXROdkhQQW1w?=
 =?utf-8?B?SXFENkEzVlNiWFphYVBYaTlXUUErZ2pEWElVZDBuTVFoeEw5N09xcVhwQUsz?=
 =?utf-8?B?NHBLQlJnZ05FcGxXdzdMcGwyckN3OWl0MEl0T0d3aUZsL1YxdVZpY2xWbHhv?=
 =?utf-8?B?NStOSDZramIxLzN3MjlVUFhUUDAzNFpNYzhLVU9TNStFQzh4cTFSdndaaURi?=
 =?utf-8?B?VG5vQjNuODZBV2E5NEtEUGkvMGM0UC9DUWIzU21jSXo3c0R1cnpqZExob2ov?=
 =?utf-8?B?V1NRemZGSlRLb3NmUU5Gd3N1ZWcyVDBzWnk4eUQzTnMvUXJ3dDQxQVREekdh?=
 =?utf-8?B?cERYQzhTVEhrelNzTEozSm5kQzJQZ2ZoeHlYYWZ5RXYyc3h0ejZ4SHlnc0Ez?=
 =?utf-8?B?R3F1c00vN21KeEx6L1dIa2JqZ0N4K1YyRHUxYmViUGVmcmI4QUJlemtFRjMr?=
 =?utf-8?B?c1dmT3RuS1pnQjhzblhHS0E3TXM1NSt4TUR4YnFwTWVQNFFhTEhxUEpKbDdt?=
 =?utf-8?B?MkF5dEVSNnRLYW5mV1IvcEZhT2owU3puSUFsT3lqQlBXODhSNWxGNXBGUUJl?=
 =?utf-8?B?RW4zMXFOTm5kdHYzTWlVOWV2K0hRR081VEVnbFV0YVdodkJLUUN2a0lwWEVG?=
 =?utf-8?B?YTN4bWdwMkFRS0p2a204V1pVSjlWbEQ1MHdzZFAzd1JFS1o4WGs4dnlveGVt?=
 =?utf-8?B?UUpqa2ljcXJjZ1VTaC9kR0l3UlVkWnQ2YzlLWnk4R1l2YlVmek9xS2t6RUF3?=
 =?utf-8?B?dVhWZUJGbWpKQU0wR1drQ21WL1FVV2hrK2U1NUo2UUUwSkxZUXBXMkdTS2Uv?=
 =?utf-8?B?S2pIZFIxQnVZV0p6WFdpQU9qMnUvNEZnb08vT29kUmlJQkM4OFBmQnM4UVZl?=
 =?utf-8?B?MmQ2TlhySlljUkRYbDJZYWlTZFJjcXY0T05kckl4L0NERnFlMDYveGM1S0Nk?=
 =?utf-8?Q?Ov2vmSnz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d394f2b7-7c87-4546-e726-08dbd4a9db03
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:56:59.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD4jWDOVsH9Nu6CdrqFLebkn55aRYqZvnweJBQ3UtNBn3A437Z10kAy9G4Vl3xkzMwxHuVrfqQzslFaTbBFYEjJF7gFKkt+GhNoK2qkNko0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240137
X-Proofpoint-GUID: rfKdbJTSMGj7HPumi7llwoaUV3-1WObp
X-Proofpoint-ORIG-GUID: rfKdbJTSMGj7HPumi7llwoaUV3-1WObp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/10/2023 16:06, Yi Liu wrote:
> domain_alloc_user op already accepts user flags for domain allocation, add
> a parent domain pointer and a driver specific user data support as well.
> 
> Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
> iommufd core uAPI structure. Make the user data opaque to the core, since
> a userspace driver must match the kernel driver. In the future, if drivers
> share some common parameter, there would be a generic parameter as well.
> 
> Define an enum iommu_hwpt_data_type (with IOMMU_HWPT_DATA_NONE type) for
> iommu drivers to add their own driver specific user data per hw_pagetable.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c          |  7 ++++++-

You are sadly missing AMD IOMMU

This would fix the build and nack the op should parent or user_data be passed:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index caad10f9cee3..bc747513afcb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2220,13 +2220,17 @@ static struct iommu_domain
*amd_iommu_domain_alloc(unsigned int type)
 }

 static struct iommu_domain *amd_iommu_domain_alloc_user(struct device *dev,
-                                                       u32 flags)
+                                       u32 flags, struct iommu_domain *parent,
+                                       const struct iommu_user_data *user_data)
 {
        unsigned int type = IOMMU_DOMAIN_UNMANAGED;

        if (flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
                return ERR_PTR(-EOPNOTSUPP);

+       if (parent || user_data)
+               return ERR_PTR(-EOPNOTSUPP);
+
        return do_iommu_domain_alloc(type, dev, flags);
 }
