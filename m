Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FEC4FEBDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiDMATI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 20:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiDMATH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 20:19:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6BB85B
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Apr 2022 17:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F071361828
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 00:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F97C385A5;
        Wed, 13 Apr 2022 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649809007;
        bh=LsvXF38xQCO8La91LyrjAYgL05TyufkNgdo7W09hGzs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NdrpcPRgttmDEIiOULxAq9RkR1xc9VEIlHGlU+wlc7m2cIZWGpSsriaVGjiN/vrxA
         jxPFjXVwxfomL8ApsC9+QOioNWfqU4CpBDdNEy8kQALfrisKfaoOSWQVneXpPzkQU3
         P4YnOJiio1ZoLzke47TtI1H9aiKeJ5DxhmaqLXkHdrCKYjKdES2dhPiWEsVYOEDKGa
         pi4rZFPKWZMlBi/bZ4RDIQ8oSGdDikHwhsddFsq7Lt9qLR6A77/q3MVwjjfftPvLeT
         TdPISKiITkbWEvDH1VXIkrXxb3Om0CO5AfHr9X26OOUAx0OdeYTuBDSKibxWBjcEW3
         Fs0ApMD6P+k1Q==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E8E8F27C0054;
        Tue, 12 Apr 2022 20:16:44 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 12 Apr 2022 20:16:44 -0400
X-ME-Sender: <xms:axZWYnj7OqhgrOuOQb_focEAH603gVwsLo_WRAuxfDFax7u1YhbeBQ>
    <xme:axZWYkD-oMlxF5GxLS44QEvF9BxVwdGeWdpXCPK_waJbhym2JaKHm78DZ1hB5LkEK
    VFYdEn6ICChCECf7ao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefhlefhudegtedvhfefueevvedtgeeukefhffehtefftdelvedthedt
    iedvueevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:axZWYnEZWliGFAb1pW0k2PJcDOBmZsYieDxqmtjGypyPm0YlKQ5Jmg>
    <xmx:axZWYkTHR0jprS1nrl00uoM44v3jI2o3zbBb6K7v9woqiDDNbwrphA>
    <xmx:axZWYky0iioqaGWKASkdTZwq22cAp01cfHCtUzDIWsFlWwXkAPq3BQ>
    <xmx:bBZWYsjOXuatluKYk95sJdmdseOl9MtVFotRTKte1juf0_HZpZuLKpSSR28>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 92CEB21E006E; Tue, 12 Apr 2022 20:16:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-386-g4174665229-fm-20220406.001-g41746652
Mime-Version: 1.0
Message-Id: <e8a4cac5-bc5a-4483-9443-c0e5b9f707d1@www.fastmail.com>
In-Reply-To: <20220408210545.3915712-1-vannapurve@google.com>
References: <20220408210545.3915712-1-vannapurve@google.com>
Date:   Tue, 12 Apr 2022 17:16:22 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Vishal Annapurve" <vannapurve@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     "Paolo Bonzini" <pbonzini@redhat.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, shauh@kernel.org,
        yang.zhong@intel.com, drjones@redhat.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Hugh Dickins" <hughd@google.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Quentin Perret" <qperret@google.com>,
        "Steven Price" <steven.price@arm.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Marc Orr" <marcorr@google.com>,
        "Erdem Aktas" <erdemaktas@google.com>,
        "Peter Gonda" <pgonda@google.com>,
        "Sean Christopherson" <seanjc@google.com>, diviness@google.com,
        "Quentin Perret" <qperret@google.com>
Subject: Re: [RFC V1 PATCH 0/5] selftests: KVM: selftests for fd-based approach of
 supporting private memory
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 8, 2022, at 2:05 PM, Vishal Annapurve wrote:
> This series implements selftests targeting the feature floated by Chao
> via:
> https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
>
> Below changes aim to test the fd based approach for guest private memory
> in context of normal (non-confidential) VMs executing on non-confidential
> platforms.
>
> Confidential platforms along with the confidentiality aware software
> stack support a notion of private/shared accesses from the confidential
> VMs.
> Generally, a bit in the GPA conveys the shared/private-ness of the
> access. Non-confidential platforms don't have a notion of private or
> shared accesses from the guest VMs. To support this notion,
> KVM_HC_MAP_GPA_RANGE
> is modified to allow marking an access from a VM within a GPA range as
> always shared or private. Any suggestions regarding implementing this ioctl
> alternatively/cleanly are appreciated.

This is fantastic.  I do think we need to decide how this should work in general.  We have a few platforms with somewhat different properties:

TDX: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  In principle, the same address could be *both* and be distinguished by only that bit, and the two addresses would refer to different pages.

SEV: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  At any given time, a physical address (with that bit masked off) can be private, shared, or invalid, but it can't be valid as private and shared at the same time.

pKVM (currently, as I understand it): the guest decides by hypercall, in advance of an access, which addresses are private and which are shared.

This series, if I understood it correctly, is like TDX except with no hardware security.

Sean or Chao, do you have a clear sense of whether the current fd-based private memory proposal can cleanly support SEV and pKVM?  What, if anything, needs to be done on the API side to get that working well?  I don't think we need to support SEV or pKVM right away to get this merged, but I do think we should understand how the API can map to them.
