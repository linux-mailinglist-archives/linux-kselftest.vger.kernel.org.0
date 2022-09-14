Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79625B8949
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiINNl4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINNlz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 09:41:55 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03D32062;
        Wed, 14 Sep 2022 06:41:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7CB245802E9;
        Wed, 14 Sep 2022 09:41:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Sep 2022 09:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663162910; x=1663170110; bh=9u
        dvku0NNJooTG5PR0CRxNtI94An28JpAV1KnmmamBY=; b=ZjHvw3a6pBffuT3xRg
        xpoDAsYdt4XL8/i/JT3v6IJjJroO/aoAmhQHhq5g6bBilEH/voNXhJn22WWPxMvi
        /FZvn0xz4b1jy83cjVTjFGR8jISB6D26oPXcyE4/Jh05WGOMMQBo2uSzJeG+IUqf
        tsAaH9NoX1zMBypHeLhhHYzffMkBrClCguZcrzv40a5a9mnFExobe2CfTEo5U727
        ilQX7CTdlZn4zZoFT3FuOaKoCRsiq+4yGYQNpulzLh/CMeqoz41D8SVnJKI/qze7
        e22XmGRw1rpvTos+1duo3HpiTwanP/OM2Rs+iImOcETLHVpgGh+VrijR6zA1WQxn
        QQrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663162910; x=1663170110; bh=9udvku0NNJooTG5PR0CRxNtI94An
        28JpAV1KnmmamBY=; b=EdHJVI6+aLmZ4CEL85sFGkG2z8mijdhi3WTBzJXCG1zC
        P55PwahnplR0MpOhEvJrBhyCuc8pHum1Bzg8fL6gA8ebL66fBvv+liNmMdcwAFwa
        y8uUNrthcmwXsz8tF1pQ3ncXP3H6zX31CZ8KBYmUkxSmWjP3hq8IrtT4wtsp8qUp
        J4nCHxGuANWdr4HLs1E8C6bcrxKd+h+bZnNRhoLXrJqsAZZ/kb41ZoPPu+LNBt/4
        ZhYmW0Z3jPGdIderbBJzavHUoMkKTRBtEIKVak5ZU2nLhYfHtHjsO0kfSjG9KuJQ
        EnZ1fuMON3EByPgHpWYlISBExOmpcZvG32Zoi/bWqg==
X-ME-Sender: <xms:HNohY8ve_0GngwMEMdzu-j2WoinjMwGGqv_a5bFsdZkaQMLkD88bWQ>
    <xme:HNohY5daNrEO4E0rJOS9eJ1cwYDP3v-FAVa518SuH9wUA_pRIwdLyeVEpQ1Xb481o
    F0oYWlkCl5by0cDDbE>
X-ME-Received: <xmr:HNohY3yUHLYns9-T2hzVdsfuq_tTnHv-wmds33nAB9yuFIKkb5JymKMtjdzg1Vi-PQBfJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:HNohY_MMxuYhCY_lW_sZgN_XAVJqC6hOZWAcTLIR5kZsrqb1QDSn-Q>
    <xmx:HNohY8-ZPRjxtF6BNQ0JhsQkY14SwfGotj5Ioswu9elQnezW3h6TLQ>
    <xmx:HNohY3UTJXhfAuRh1iWerMz_fyW7_lza7Aco2t_MBtaPF-1pSlp07w>
    <xmx:HtohY_eICiNZzS-lR2V0SZqZPprnKWCaYtbKNid-25sIQMt2Gifytg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Sep 2022 09:41:48 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C4BF8104669; Wed, 14 Sep 2022 16:41:45 +0300 (+03)
Date:   Wed, 14 Sep 2022 16:41:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Message-ID: <20220914134145.3llpjs76wkb3yacs@box.shutemov.name>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220913175440.wahcdmaumeqjgzmh@box>
 <c5868924-f2a0-d6fd-c757-ae539194f9f2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5868924-f2a0-d6fd-c757-ae539194f9f2@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 13, 2022 at 06:23:34PM -0700, Sathyanarayanan Kuppuswamy wrote:
> After addressing the comments, the final version looks like below.

Looks okay to me. You can keep my Acked-by for the patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
