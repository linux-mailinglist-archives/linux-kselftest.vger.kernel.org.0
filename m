Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08C1030B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 01:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfKTA1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 19:27:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTA1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 19:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mMMDebwACb1zY74jKV4pvVdex8iqpBiiTHzIEmHaphQ=; b=jhQYalGWSAgIRi5O80fqP6It9
        Y6JbDpGt445GNBdb7e0y2YjDLv1jk8Wsiet4GoVRXcrXcCd8GTil8+UQKy6LfZtnqAK52UDeBjhvz
        oa3hLNtSOFH7Tgz2tH0kQz5YE0nMpnJyG8OP2q5qXgDKpoS4K3velaABKNCBGlre9YqA2L6FSJDbZ
        JGZvF9X7acDtcLD7dDsZQzawtBAtejgH+/xQZvRshagTroMN8/lbSShqRFgTy0TEeaNWALPONsSSe
        rjcw9iUEL5BLkfg+PS0ASooEQxZLGhlsCdzMmuvH5XvxjCN1LNjRLupAJgAXG0cQeQGr2qQHrmCUx
        AXKUhIB8w==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXDqa-0000Ai-3i; Wed, 20 Nov 2019 00:27:52 +0000
Subject: Re: [PATCH linux-kselftest/test v3] Documentation: kunit: add
 documentation for kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu
References: <20191119003120.154041-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org>
Date:   Tue, 19 Nov 2019 16:27:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119003120.154041-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/18/19 4:31 PM, Brendan Higgins wrote:
> +How do I use kunit_tool?
> +=================================

Hi,
I haven't tested this, but Sphinx (or some doc tool) usually complains if the
underline length is not the same as the header text length.  (I.e., use fewer
= signs above.)

> +
> +If a kunitconfig is present at the root directory, all you have to do is:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run


-- 
~Randy
