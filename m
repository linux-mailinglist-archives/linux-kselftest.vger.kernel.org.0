Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18539722F5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFETKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjFETKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:10:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C3106;
        Mon,  5 Jun 2023 12:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEVQFfuPCmM6x1lN9P6S/bHcKdvLKXmaSFczeJ58XqK7a+aUgncQrrRpmd10S4/wwY76sfx4PGmv79eTKPWSd416+J5/v+nElHaochf4RKQorX91CQfZRUawIFAIP244jTJp/iBu975jnz8cTgrI8zu+Kg4S5ueKgiyUhLzvWdd4SdeYJpi1BnoEXkCDVc+tAsE25dhEzeitB8NiygprWit7IOvQZRJfah1J8ed2QSgtYhzRUobR6yqWKzm/XkCL+hm+v6kLFC75hAc/gjKbpKkI3gEHEHMpIeIUTTigpr86IlqZrjS4LvrAKiZc/ZZ5K+92z3fGj2eb9ym8OpvToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNojNHi8++EX5PhbN/6rrA5jmR12Pv08iyaqvGS8oog=;
 b=kfR1Ih9vFJ0Z5MkbVPR1aDxL7ZeHSFWfHidqOlUsjJVoQWhU5IQmxYYTRw+wo+Be7yH4LDVhtfW0rrppls0lXmR53kYnIlK4fYu8Olsq5tUJEdzfKmRfHVOGn00xjxUDOlyMWmRdwA2q4UMwNF28clSnBGuAz1GgItwiqo4gWuqd48ZdLviq4xnaIlqQ43O2KvpYQJsJyge7XXZbtNk5ZzOCqr8HL41umrv90F00kZWbGX+tmFharRaf6jhODSDE40ft8Z8SOPK0PWVRror1TU06Rb44xEulBLcpKXlPZWwpjDi20XEDv5c9Yr5mJyoPnJNxtZ/ZuBDPt3c84G5bcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNojNHi8++EX5PhbN/6rrA5jmR12Pv08iyaqvGS8oog=;
 b=AgCF9EF9/KZ8aO0U1pl+SSSRcTIY24pdI9ZBr0IJrHpIjRK7sIX58XUfD4iS+X3NvSS4f254oIHqoK4BXodFk58p0wZ2pQ+1SnkYkKjOXshBBGqHTUSTLGRPmVpYyAcTSM6xbcSWbZnL8ITQP2w2sB/G3nXsKuBPkjUVpujwfjeKf1RyD6iYb5H+/OHJ+HEgwC6O9NDRPoRq2O3BGsDaTzpRh9o0u4XBaXRQYxFg6LijzD+aGM9GfW1JBib1S5KsZdgf8GRCeyFzZOmANYfwkz3jy2FTHN4XoqEpf4Ynpzmmr3CxwPL0CBFXkiLsxNxIoCboWZUDymuszvk/BLKN6g==
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 19:10:08 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::10) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 19:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 19:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 12:09:58 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 12:09:57 -0700
Message-ID: <64e21a2c-1bbe-4ab6-e67a-29b2d1d1978e@nvidia.com>
Date:   Mon, 5 Jun 2023 12:09:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 10/11] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-11-jhubbard@nvidia.com> <ZH4GUODwj9L9paey@x1n>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZH4GUODwj9L9paey@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 654e5878-3456-4332-8ec7-08db65f87a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2UYWtJy3ooDf1BPKbSxpogN4vaDXZabU1fEws3+LaoalsYrITniBOG/jmVp0BNXU5ne4CiH55AVJMBwv5YpFEqzcrHXGF8cqE7842WDNguDeBkFVlQMSAA2SZTy2VrrBvSJktL66W8b78Z849/HzCGJNqNiKZgsctfZ4EY/idV5m099xoiEGM/HurUb9KDXSCP57K24PvO8OC30OHwWvClKgTSF+YQP3bM7Pc/vI8CN5+UB7vSqrTSLy3OL2LIgpu+CTCNTzxgpwwn6KYQkGRCDeUJK8nJZ3duMMCvFb9dNdiopQJxNcd14ukgd3G5gVzdR95G9ZsSOFXM1s7s3ErEG5mPDl5oLvCIXX/cL7opDrayFtPB7DpI0VfbIUNyYUfiVwIAvLnSMsFJp4vNlTL8Le7saVVJkb9wm+yMLkgC+W5lK9tgzYsafuwRUUFj6OcLtTWOO7XMiYUkALfTJeFf/YcZQhV6iSEkfAf1AKiWDoLgDsAJxgkOMApgx1pI5w5W7mRS2qHvvUO/LFZgxuXX1r8QRnhhPXldMucE/j8vGX+sAHsens8QgZ34Tt0W5SDpnzzddlQTu9Y+UxEiMOgzDYyA6+xneP6lfGGs8TGhUIV9tiyUhWZmFOd+QU0Awvj1Fxp5AucxgEghOEAYmIb75mkLU2CkgvrgZDf5pcVjyDY/owVjy05vXUNvA8xOKhUe6BVtIASGRazxiY7RjF+zs3KrkswE1KBZ/XLoEeQHdpKp5TUfJ7PHOmj3LvC5LZLUk/Zlt+A3bkEmcETLoAQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(478600001)(54906003)(16576012)(41300700001)(316002)(5660300002)(16526019)(26005)(186003)(6916009)(70206006)(70586007)(4326008)(31686004)(53546011)(2616005)(40460700003)(2906002)(47076005)(336012)(426003)(7636003)(356005)(82740400003)(40480700001)(36860700001)(31696002)(82310400005)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 19:10:07.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654e5878-3456-4332-8ec7-08db65f87a32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 08:59, Peter Xu wrote:
...
>> -$(OUTPUT)/uffd-stress: uffd-common.c
>> -$(OUTPUT)/uffd-unit-tests: uffd-common.c
>> +$(OUTPUT)/uffd-stress:          uffd-common.c
>> +$(OUTPUT)/uffd-unit-tests:      uffd-common.c
>> +$(OUTPUT)/hugepage-mremap:      uffd-common.c
>> +$(OUTPUT)/write_to_hugetlbfs:   uffd-common.c
>> +$(OUTPUT)/ksm_functional_tests: uffd-common.c
> 
> Sorry, John, I still cannot follow..
> 
> As I said before uffd-common.[ch] was for uffd stress/unit tests.  I
> confess my fault to not have named it uffd-test-common.[ch] already.

Actually, given that there is nothing *except* test code in this
directory, I think your original choice of file names is just right.

> 
> I think it's fine to keep uffd_*() helpers in vm_util.[ch] for now, until
> it grows.  Just like if one day we'll have a pagemap.c test we don't
> necessary need to move pagemap_*() helpers from vm_utils.[ch] into
> pagemap.[ch].  It just keeps common test helpers.
> 
> Can we avoid linking those into other tests in whatever way?  Maybe
> renaming it to uffd-test-common.[ch] may be cleaner?
> 

It sounds like you are suggesting this:

$(OUTPUT)/uffd-stress:          uffd-common.c uffd-test-common.c
$(OUTPUT)/uffd-unit-tests:      uffd-common.c uffd-test-common.c
$(OUTPUT)/hugepage-mremap:      uffd-test-common.c
$(OUTPUT)/write_to_hugetlbfs:   uffd-test-common.c
$(OUTPUT)/ksm_functional_tests: uffd-test-common.c

...approximately. Do I have that correct? I can arrange it that way
if you feel it's a better end result. (And it's better than leaving
uffd*() helpers in vm_utils, imho.)

thanks,
-- 
John Hubbard
NVIDIA

