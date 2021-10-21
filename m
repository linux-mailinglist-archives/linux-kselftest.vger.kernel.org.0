Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57212435969
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 05:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhJUDt1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 23:49:27 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:59681
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231278AbhJUDtI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 23:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2NFMlxq92Rpcn1nJqhZnI6WQkAsAORzJfD8UvwteQ02gMb/RE+tx7BhgEd9OjVJWu3je9hZyG804SwCa7yPOM7samIFOcQcC2nClSzgqhjI90eXyEjrAVXH3kCrZ2WY8elMGkzZGosGDAdw4k82dgVE0PlISVOZeHYIpYHRlcjXDzNVWF4GG+CFPmELoUv+Rv8tP2fq0q0wo2AATyr4rurJzjFb8rEjqhFOTHNYDx6nGDbCIH+wDhT5wXuQ9CFytrZWkhuuKbBXLro1Q0ubqJ0ZQJ/rjg3QHFVzFvwKt3iQOL2C9qK8UpQQf1vMXN/0Mb15tuaKLghoaSmHQUbRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B7FHPeClN82F+8WLZw2PClhut03hPtMaoq+Tzp/QB4=;
 b=OX4JMri7ndyLBIIp5KI23NVN5Cfa2NGxP4Tg3pYMNh0zFJJjVf3YyeRf5djcX4U2sDKzHSOsmT0x76b1ZncvRHLj6HjMg8Rhomj5Ri1Y6AoMsaaMhw7iKv9sWg2AwvEAccc5jVEfVSBZLIP2Esm036DU2nuSQ1NyCuh56QWMYTg/SHqt4MQ7YC6G8IO+mcG8pbIR+JgrvycS3SA5YuVPb9q42Z4Ql8Sgx0R6EtUghYtjmV6KrxrprD5l0kIN88SU7rVM5zcK62vpDK2TFq3mTBQyAzf9cwU6RReKgxaeOXR97en7gx9Kxmelo74IQGDaZPo3rGK+ZGO2HjxTn/FX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B7FHPeClN82F+8WLZw2PClhut03hPtMaoq+Tzp/QB4=;
 b=gUzs83Rd109O0u2QQdjaJiQGusEcyadDWTjkk5vshnMuKKkaWV2iVLyNcrgOk9bi9ThoAHRdrbYXywDp7zW/F8Lhmh3JO7JgYeuE4hB5w6xteIHMg48qVtju/fRIq2xIzyLM6zouOjErCl3ySLgKeyfmxF/Jzx8ezaN2VTiKk+U=
Received: from CO2PR05CA0091.namprd05.prod.outlook.com (2603:10b6:104:1::17)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 03:46:49 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::86) by CO2PR05CA0091.outlook.office365.com
 (2603:10b6:104:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Thu, 21 Oct 2021 03:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 03:46:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 22:46:47 -0500
Date:   Wed, 20 Oct 2021 22:37:23 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Mingwei Zhang <mizhang@google.com>
CC:     <linux-kselftest@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Varad Gautam" <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Ricardo Koller" <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
Message-ID: <20211021033723.tfnhazbnlz4z5czl@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-3-michael.roth@amd.com>
 <CAL715W+-H7ZSQZeZmAbbJNGKaZCNqf4VdLismivxux=gerFuDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL715W+-H7ZSQZeZmAbbJNGKaZCNqf4VdLismivxux=gerFuDw@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97a4223-b87e-4d2e-5308-08d994456918
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51939FD5447087002ADF679995BF9@BN9PR12MB5193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yullsEk49zwudm4X8RQ6QIbD959Ugfkx/9IzTvdSz4lI/nHAGo2V49upqB6/4F7CgtIrME/oP8aoD/zmS/5w9c0BGHHdkN3isxwJJdrSy1wpjwc0PvHFracktHLZIZaODy21gOAFmJHvYA91324zjxgP24eL3lj6gd2eawM9VpEG+f5Nej4tz5Kc8P3embSa6ifsaiFjSz51X6m454WjAt8IGJKHbobiRLdPVsokGY0JaDGbqt3pNYiZxguUyW1MJlRstkLfRx9+bVFvF8WT9dbp1HHK9gu3Y1QTuhWVT3CKQOLBzD78oiQf3PVYwDPqnH3m4CGLvgxq+huLCTiZkF9iaR+DYg+ZYsoTY1bvTOIVH8CGZ4OEqAGXvqG8VMfGAa2oTrI5R62Y/1K8XoJTx7Brcj4sCquh5U2cT4cEjhKfDD2jOTJpy8ofONFLs0+scR2HZAZuOr9XPNDVA6l7EEtm+iFHJuF3L5Zq93nXDofIm4QELaUgjeCEcJSZmVIRuFZOtTZs+jURmSksfNkOr1Rzv6W74DVyZgkl6g99xxGlniXiq2c7uVYsehLgwhvwoHhOwpYMQ/ZicjVL7Kw3KduQ0CcOUAST2HD4GtqqGH1oC3jUH92WvEOB0jZsAZf5Jf600Q6hOpsBH9jFYn7Hwy7rmqY3XrZ+WWIImqbUcP+ZS816f12H+13Sfb8myBclV5JHH3q6eys6F+UMzQ3hnREiaeibF9kK07gH16nfqpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(83380400001)(8676002)(16526019)(2906002)(70206006)(36860700001)(6916009)(5660300002)(8936002)(44832011)(47076005)(2616005)(70586007)(54906003)(356005)(82310400003)(26005)(186003)(7416002)(4326008)(508600001)(316002)(36756003)(6666004)(81166007)(336012)(426003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 03:46:48.4972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97a4223-b87e-4d2e-5308-08d994456918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> > +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> > +                             uint8_t enc_bit)
> > +{
> > +       vm->memcrypt.enabled = true;
> > +       vm->memcrypt.enc_by_default = enc_by_default;
> > +       vm->memcrypt.has_enc_bit = has_enc_bit;
> > +       vm->memcrypt.enc_bit = enc_bit;
> > +}
> > +
> > +struct sparsebit *
> > +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> > +                          uint64_t *size)
> > +{
> > +       struct userspace_mem_region *region;
> > +       struct sparsebit *encrypted_phy_pages;
> > +
> > +       if (!vm->memcrypt.enabled)
> > +               return NULL;
> > +
> > +       region = memslot2region(vm, slot);
> > +       if (!region)
> > +               return NULL;
> > +
> > +       encrypted_phy_pages = sparsebit_alloc();
> > +       sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
> 
> Do we have to make a copy for the sparsebit? Why not just return the
> pointer? By looking at your subsequent patches, I find that this data
> structure seems to be just read-only?

Yes, it's only intended to be used for read access. But I'll if I can
enforce that without the need to use a copy.

> 
> -Mingwei
