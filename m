Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27981689C96
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjBCPEa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjBCPE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:04:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65656A0EA5;
        Fri,  3 Feb 2023 07:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/TyiNWliEUnqrXH+oYCtCzHv52184YPwbjVHBry/HiTcmllboPSNVRZYwAN+bRx2ST1acWb9yreqjjkywrCcprAeNte+FD9gcgCrQ7MlM3la5e/iYzoRAAegLqs+DiKNRfQUclf2ZFhO6X7a1mWYwXU3s26RkGfS2nqWX3oBb3pKSCSwBDCZm8ZXIUBT44ULQmC2ZOpD9rRikKC72TA5E2Ns9WYNXpVmFUlmlVhT152Awypw+GheViZZvzcZuopiF/unQ+R+2ovCgvAsSc+jb/SDGcgzopIq2qHAjth/5TgE3BMDY4G6p7NY1L0jDwUZKtUOnZhelhUpAJEr0qQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb4MNn1yqAaTwPuv5ew/Pbw/grgTgEC0T55qmbNQN5k=;
 b=LDowJgt78TahJy4FzIcD9Oi0EHr3rORvf5EKOA0gBFEkDEFzshSHqBqMjLBFje+CemR7BwKSY3oDwwQI0V0aiP4V1dNJF9bspACvIwbI6vgexva/1UPi76brkRT/bBi3kx+MIF5b2ywzyIa8jS9ONvLFWoBQdVP4rjh02NpYp+hQ8JA3xnPCnLs2CKF3vRw9izE8Xe/77LLvcackeTB4FjlgGjgptJMRSFNN2awXjCvjrxge47yJP0CyUADBWQuDGC7QAx2rB0b+NiZPZzYInlL41cikS44d3ZAK+OYZ8NjVYXD0m8y5djqBH0S6AcZBnn+4T2N4bFEwxFC1AOVXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb4MNn1yqAaTwPuv5ew/Pbw/grgTgEC0T55qmbNQN5k=;
 b=TuWssrVaOuqrqid9tOmF8tlyAoLJrghr4F0+JQpGyUZzV2kNwwqfvnHX67RLd6rniRtljS6yxfWToBDqKH3wafLpUiTsr5QasxdZTQDVTRcuYXZ+gAcrqUGE2mNn1jpUGK0fpSV8VPrGSJivvs2DIOu++TJ75hCiOElSjDudHWAnKP1aRQmUn3a5mGTrXgONg0XLciDPmMKdW42dimw+8GYCm8sIClgZZ8heDk1DCdJlmCiVaija/gV1NOYToF2jW9aqI1nnZOHt2ff1oy600Ce/gvbag8mwr24xQgOEeKvIv3QJpHxmfgbhYPhXMvnyoRZFUK+3FRozzXGbJfLM4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 15:04:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 15:04:26 +0000
Date:   Fri, 3 Feb 2023 11:04:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/8] Add IO page table replacement support
Message-ID: <Y90ieTgl7I2GZfsX@ziepe.ca>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fe19f1-4114-4cf0-d3c0-08db05f7f106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP7MNSqI3JM39zf+poVx4LiGlpzMtt13NbJBejmbWii7xX2pN9siz0y7bZ+dZVclFlfXZES0R1fGnZObb28hlPum9gid+Mg89b+2f775/bYu11VOhyVVE/gqAKVumefsP4+uZy/kINIe7X/r0VF/dsv83SUVCccZIfqFPTNUkfR/UXxyJ+fbt5ASUPV/hsQQunME4G32BF0PrDhrkh+VLDj6d/HJGrm4PK0w2JyqMq0fPe2m1tniD0RS4/y30JsAwd5fT0PJoZpP/MSySPOdpy2PwiHgRXm96eRYQXr/4OPpci/D/jCPbZxFohugzIi1dh/odzxm5XUvNmN2ZVtQN2PvVR88E+F/RHqo7YxAG/iqHAPTwCRE1BRTeyR4SxDYzSgQkRN6SHn4mTi2OuutbnlcZnpECaGYP9EKhzoTnBlfhwwJWssL8HReXKpZ48Q1DBi5tv+VS+P4tHUSm4UMkTGJ4wICiyV0uxfV5vZiJYjRktE7VoKkZbBKzdZIo3uSqyiq/5rg6hj6ufUmQYRpC5uhntlKAyYCBNM8EWuJfxndZhmjv14D/353dJRoJ3BssaoYTUoKQKdyKcAzFyQ1aUZX2LZAwEmVzwLdOHFOq2gCQ1JYgGzdWt4EoByL1mTDeZTRL1F/9PyFW+N2ysbUpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(86362001)(6506007)(186003)(26005)(54906003)(9686003)(6512007)(478600001)(6486002)(2906002)(4744005)(41300700001)(8936002)(5660300002)(7416002)(316002)(66946007)(66476007)(8676002)(6916009)(38100700002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HzGvuqghuUHsq/V1ljURSdWH8kikxKNpJiDEr+yQ+i8cek62dbBHNVAolcIB?=
 =?us-ascii?Q?O0jEAFgVGOEEsIKn0uP1FSvc+jlft4kfbId7q/jo0hN6WZv8Yb9Xdr3BoAF8?=
 =?us-ascii?Q?sO7BGwDZoYme+JIywz+oDCiT4jzH2tbu17wQiPcVnpj3UnjWIvW5trfD7nE0?=
 =?us-ascii?Q?B9ar1gy2IzafZ5WAitdfhFmBTcZFzUr8o5D07cBL3J0u4QcDbiFujdAGp7JV?=
 =?us-ascii?Q?z+K0bdf7xiofzW/20US/a+D4kXXBP4D95wHBtJ1lO4K3EoEoXqEcce20l70a?=
 =?us-ascii?Q?FXNUDObevohtaI4O57Eesk9yREHXWv+usoXISRXoqMJs6/orIOfXhfCbh+i4?=
 =?us-ascii?Q?T8MMIeulnulNvcCrdOpFzP1U6mK6pn8aPlf5hK64yU14kyouTtWg1bGtqINR?=
 =?us-ascii?Q?2UECtw0bc1XH6czh2HAypXejEq6Gez/9UEHOYXSp3ZlyJWQn1451HiBfWQOv?=
 =?us-ascii?Q?qQf3II5HI28lSCRyMqWAWlSdd6UqrJ2RBcPO5UTWV2uIeDwsG4SFvVdSqVh8?=
 =?us-ascii?Q?bEPSOEbHJ/fs9qVYX3CNHUpNjdfp3P6H9GNBFxAVHcEBQ8/nqALlu4mfSfvm?=
 =?us-ascii?Q?anGN4MoMabce6v26Jo8e+RYlThxAVlpL/qfgOw+2j5xZ3nYchZvLEMb0idVe?=
 =?us-ascii?Q?zaQPAoLkPnc0UIWvP3JrWx8NS0EB8iQzaccCa+kgWHN7wGd/KtJBKZEWS8ZQ?=
 =?us-ascii?Q?1+wDZOGiABDuKgIrY7VEhAwffJ+0i7f0R+XI4SdQhaTk7uACLMfHx3awZMqk?=
 =?us-ascii?Q?xzHTyfxKa8XXFu354pwrmeuuj3aGybvRWzfg9aRUKImE0vg6pUVB7zyBrEmX?=
 =?us-ascii?Q?8mdVMJhEPTG0SQHmoqRiVYHRH50dWOZ5QgUYxcLTvebcu1piX9cWbs3SjZQs?=
 =?us-ascii?Q?6QG6lH1oTubV/uZV4aDEuepIMqezNRNVVMQsj9hkOWgbiQldlK1GaLPzuwhh?=
 =?us-ascii?Q?gJg17eqG2UrTLUW1LBFjJ9iwUwzwmmNkKoFsCnznrvxRlpyW2XyIBXhie+dp?=
 =?us-ascii?Q?e87qG23CTjbg/mhlIyP6Gzo6HfXNHLq6Prw04mMLMLak9kvmrFPCBG4I4eKq?=
 =?us-ascii?Q?DGMUIQ9aIg9M1a52IAnWxGdyvDRHp251PkCLsRaaKeLdONhRVAPFRIB5S4nN?=
 =?us-ascii?Q?9VRJr01jbKhWDpfAqUA7tgGSEAw1A7T+XOj0QVAuu2NYUAddAzfk4P/N/jpo?=
 =?us-ascii?Q?ZIuJKJrCycjpnDl4C3/LpFVjqo5h6Ct5x5pzP9oAMNuNP+asM27ofdxcuNPr?=
 =?us-ascii?Q?fKXD5aoMIlutpgV1lECAg5pmLMdoJuHcXpOHuRIKQuQrKPeSfwNlGZeLLuHP?=
 =?us-ascii?Q?XXh4Lcq0JFN8MpzgOcdvPxiDF/x4dhDmKxK4qaFX191OgGbCBmGfkBesupNi?=
 =?us-ascii?Q?LIx36dd3OM6BYC75L9hDEvupMSIMuHEh0Eh0qLQkkZlCPoRk0FgpGPjm7vW2?=
 =?us-ascii?Q?HnotgElp0r4lMC3Bsvc/2ee51jKOmZTo3K3hZPgXG0sX9MIttDbWx/QeLSmY?=
 =?us-ascii?Q?BN3WKAklsazC6RV5BvkBNUOTtLVbFQeu38+CgO8HncZfaiTK2go+PZmXv8ut?=
 =?us-ascii?Q?UEqZZI2XlVdPAuYphZsDT60ySyGMEJiagf6NaP2v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fe19f1-4114-4cf0-d3c0-08db05f7f106
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:04:26.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5taOQ6LC5x8cSf8RlqJoW35Htuc/zIhjxRd9GsG+cBLzz7J+UQ+bmYCTlRq9OvLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 08:09:30AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> > 
> > QEMU with this feature should have the vIOMMU maintain a cache of the
> > guest io page table addresses and assign a unique IOAS to each unique
> > guest page table.
> 
> I didn't get why we impose such requirement to userspace.

I read this as implementation guidance for qemu. qemu can do what it
wants of course

Jason
