Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB61B076E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTLae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 07:30:34 -0400
Received: from mout.web.de ([212.227.17.12]:42143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTLac (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 07:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587382208;
        bh=0B52QO5d88rlSA3Ua9U36vat2jaLtIQ+5fObyjLI1LQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CWuuWOAqPoSMg3d2EGJcAoupSQT30uN4rtBpYQdIX+oFdeVpQY4NviY4goEp5kZcu
         1lEYgTp2ea6R7Y14O2V7QWlqVG/QdoB6ARy7MdT/32EzKYg8+cLa6IGsqo2jjvObvd
         Q4PMVrqBEgviW/beuREJUN0jFyFXEb5iY7vSGevI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qav-1j0s2P1nXZ-00z1o2; Mon, 20
 Apr 2020 13:30:08 +0200
Subject: Re: [PATCH v2 1/4] selftests: kmod: Use variable NAME in
 kmod_test_0001()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kselftest@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ff9ef06c-0607-8b8e-b80d-6a531921a67e@web.de>
Date:   Mon, 20 Apr 2020 13:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:g3ViuacKBow5chrPunQBhdtgEYyThlgqtDBl3bZfFPcCG/bqb93
 V47DPJHssPqkEyCefpbYS8gBbeIrIQz4s7HLYOplXPv31BDY0GvPgkQWJSwmtXX5tJPu5Pm
 X9dW8s2gnElr4Q8xlI32BkRyP1fKJ0lUgbSh/TOof8XabAjNWCTpHxjrnwPZoA1Im2EzNng
 YMktMnpJ5qz8w2Fep2AKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UUVuJhNSVag=:UxEHXjE8ZbWBac3NugaIBX
 fODaneXxP8wG0XQfgfpruAb9QSjs98UYMk1a6J7mIVdIuUh2eKGFX15gNzuZ8of/tA/e1dJmX
 Wm08EKa9G9NSKgVSJXU8gqX8J85+BiX//L3WbzIRNV2qViC9JI/nR4xgYADDDi4xHBR5vV/eT
 p6FSbSLWTw6YA+4lzKIVN7kBlvzlEGCI5GzyP8hrzW926oBKmeQoO/UWu2awmwpSpSpvDXu7R
 LOOAp2nBocPXSzLjdhTRaZbtTByQPqK4VlFgQxR1Z3hKMZvw63Hlh3P9EIdm+7QUTzl4GmNbc
 02H57zQ1rLWYIYdf1S8jZ5cYtR7g22QpD2iXEFTNhXD98d8OaLm9A2bNgqdY9jaAa+eDeiUyP
 /RVEzAr+2o/Wel3GrkP7oGix5UMmV9SDww35iXFz7xtTrcDFjG31pUN+KGtdx1nO1LHZQqxev
 aiLnX1TvMqbgOTIJpAPT1VMTckpApZLuDXzJtIUQFIGSkKeNezlpqFhdyEOAtQK1+99IEgqM8
 ANr0ILI5JwUDN6DRtQlBcAdDZJuv8Cmn1oMr3bOf003b1wYThMJE1Z0+ytGiWCdEEhsnZgoxh
 Eeco4tMwWNNgCTXUP5f7rfRqEZsWvIv8jmjCCyQ1UO84wfW6JHt83ZRoHlwwfEh/aolW4mHrx
 ZO5zU0QXGWJmntYmmXq4YoKozeJaldHZBTb/Sk7/HU7XTpJrwIesq1bxeYO32Pyc7IZ8ZUVZY
 yrobG/3dugZubcmAFQiHNsf17ZoHvHnALNO83r5VNJR9b90varUf/zMjbJRv0gE2FUMRylWQz
 ji93GMbFOFL3Wfu6wTL7i7Z7CqWkNGOEhj80df6v9MxvPAQnEDRYA2Rt4hUJ5bq3keWI2CG3Z
 msqIkAGZ/p8b1wO1nquNJ1Xf5olBhQ9G81KtY1OdTAzUaQsA34cIRuXuckgGftUBXaXgsO8b6
 L+87LGSNpFRy1Jr6/eXJZq3AvKNtKfwRc9QpeB8TDpCKUBJxJOPfRv+wsdrjmj4Nb4B6rwyCt
 pzseqixU8UBo6AyMNIH1whZpjP3ZefRhVz6bdEZZBTPMfq4ffm3PNn1tXux6EGEsXOuUyesO+
 v9EARnWVQ2ocW5HrWkJBihdGv45Nn6zM9rFaaSQ2r8Vle7BRjINedg+ASsTTD4jGD9iAGgMDB
 NIBYmvrsKmsPBElx89kKY/qJml8z5zoqKhfVqqb+sH8L8mKr0bybAPbNXWzDHpSUFHYB1WSTU
 ZoBh4PNQGtWvYEuKY
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Use the variable NAME instead of "\000" directly in kmod_test_0001().

Would this patch series have been a bit nicer together with
a cover letter?

Regards,
Markus
