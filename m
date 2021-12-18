Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE954479838
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 03:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhLRCmm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 21:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhLRCml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 21:42:41 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085CC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 18:42:41 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i63so6150805lji.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 18:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jN5Qo9OmGdr7GkJXFJ/7dRf4VAnfjuaoxF0+TxkUas=;
        b=eMQrMU/k6WAjpM93HgUXoLPOODR7Bdjr/gxuYigtV4MzSWBzsXRRsW/yvNCxfNTUjm
         DKRa9Up5lhKzKyyO8YGQZyuLa3xSt30V6gxCslPMPfkb0p25DiB8t+co6zufTut5uZvv
         GaoQ6d+YeUTc8df1kdde0nBzX7Uk/Y/qWfiuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jN5Qo9OmGdr7GkJXFJ/7dRf4VAnfjuaoxF0+TxkUas=;
        b=7EYhlfR1k0udmZvFh3dEso8OXCqgEqs1haExFc3ignTq+YFJ4mQEKoJPGBAKxmOt9v
         eXbBd51YbAeWjDXr/oXwVMAMhq2cpxbuV730rSoLARSUoVF6T/b93+r7YkIX79ntAsnT
         noJiLfkYtlkYUIOntgKFzuW4CWaJgiD2/ZXD7qg8MKLIs4jrMz5KLRTTSODzJHYQW5+V
         8Z0lmzwf6bP6Il26z2BmquuLPAQlXVnpE6x4CGShKicaWM2kJTv3LTGbaf0CRZQKLJ4d
         TtZw6tb5loP3Iufu5alrE6LCZ8oNuWQ+HS/k1HJwwNtwrJl8mVAgKbyyhWnhVkpZJBr+
         xW2g==
X-Gm-Message-State: AOAM5302D1Ehgn6/ffBs++pq6wsSsc8dlf7xwG/kIErp5yGzMXiJibE+
        ipXYKEQlMWF7aVWYdf2D6MlKT6wa5uxxbtq8amg=
X-Google-Smtp-Source: ABdhPJw0m9CQY185QHj/YPEQVQi4sGOk0ge934P1ng9aLdA/8yAZiUWmGGyUOD1HT4dQ4UkKqGxZ3A==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr5242483ljp.498.1639795359437;
        Fri, 17 Dec 2021 18:42:39 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m17sm370340lfg.304.2021.12.17.18.42.38
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 18:42:38 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id bq20so7283261lfb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 18:42:38 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr4597536wru.97.1639795347544;
 Fri, 17 Dec 2021 18:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com> <CAHk-=wjjNx2Ch2j7P+7vDceK39PpmrOqby3gXuTY4aj62dowFw@mail.gmail.com>
In-Reply-To: <CAHk-=wjjNx2Ch2j7P+7vDceK39PpmrOqby3gXuTY4aj62dowFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 18:42:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
Message-ID: <CAHk-=wj+VpgJ3RfRQNxYS3xN9O01rwWnSBX7mztxFaE6BTLzFw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003201c405d3629bc9"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000003201c405d3629bc9
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 17, 2021 at 6:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think the hugepage code should use the exact same logic that the
> regular wp fault code does.

IOW, I think that this stupid (AND UNTESTED) patch should likely just
fix David's test-case with the hugepage and splice thing..

Or at least be somewhat close.  But it should be paired with the GUP
side doing the right thing too, of course. Maybe it already does,
maybe it doesn't, I didn't check...

And maybe there's something subtle about the page_count() of a THP
entry. Again, I can't really claim to have tested this all, but I'm
hoping this makes somebody go "Ahh, now I see what Linus means"

            Linus

--0000000000003201c405d3629bc9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kxb7qbqw0>
X-Attachment-Id: f_kxb7qbqw0

IG1tL2h1Z2VfbWVtb3J5LmMgfCAyMyArKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0v
aHVnZV9tZW1vcnkuYyBiL21tL2h1Z2VfbWVtb3J5LmMKaW5kZXggZTU0ODMzNDcyOTFjLi45ZjUy
Mzg5ZWIwMzEgMTAwNjQ0Ci0tLSBhL21tL2h1Z2VfbWVtb3J5LmMKKysrIGIvbW0vaHVnZV9tZW1v
cnkuYwpAQCAtMTMwNCwyNSArMTMwNCwxMSBAQCB2bV9mYXVsdF90IGRvX2h1Z2VfcG1kX3dwX3Bh
Z2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJVk1fQlVHX09OX1BBR0UoIVBhZ2VIZWFkKHBhZ2Up
LCBwYWdlKTsKIAogCS8qIExvY2sgcGFnZSBmb3IgcmV1c2Vfc3dhcF9wYWdlKCkgKi8KLQlpZiAo
IXRyeWxvY2tfcGFnZShwYWdlKSkgewotCQlnZXRfcGFnZShwYWdlKTsKLQkJc3Bpbl91bmxvY2so
dm1mLT5wdGwpOwotCQlsb2NrX3BhZ2UocGFnZSk7Ci0JCXNwaW5fbG9jayh2bWYtPnB0bCk7Ci0J
CWlmICh1bmxpa2VseSghcG1kX3NhbWUoKnZtZi0+cG1kLCBvcmlnX3BtZCkpKSB7Ci0JCQlzcGlu
X3VubG9jayh2bWYtPnB0bCk7Ci0JCQl1bmxvY2tfcGFnZShwYWdlKTsKLQkJCXB1dF9wYWdlKHBh
Z2UpOwotCQkJcmV0dXJuIDA7Ci0JCX0KLQkJcHV0X3BhZ2UocGFnZSk7Ci0JfQorCWlmICghdHJ5
bG9ja19wYWdlKHBhZ2UpKQorCQlnb3RvIGZhaWxlZF90b19sb2NrOwogCi0JLyoKLQkgKiBXZSBj
YW4gb25seSByZXVzZSB0aGUgcGFnZSBpZiBub2JvZHkgZWxzZSBtYXBzIHRoZSBodWdlIHBhZ2Ug
b3IgaXQncwotCSAqIHBhcnQuCi0JICovCi0JaWYgKHJldXNlX3N3YXBfcGFnZShwYWdlLCBOVUxM
KSkgeworCS8qIFJldXNlIHRoZSBwYWdlIGFzLWlzIGlmIHRoaXMgcG1kIGVudHJ5IGlzIHRoZSBv
bmx5IHVzZXIgKi8KKwlpZiAocGFnZV9jb3VudChwYWdlKSA9PSAxKSB7CiAJCXBtZF90IGVudHJ5
OwogCQllbnRyeSA9IHBtZF9ta3lvdW5nKG9yaWdfcG1kKTsKIAkJZW50cnkgPSBtYXliZV9wbWRf
bWt3cml0ZShwbWRfbWtkaXJ0eShlbnRyeSksIHZtYSk7CkBAIC0xMzM0LDYgKzEzMjAsNyBAQCB2
bV9mYXVsdF90IGRvX2h1Z2VfcG1kX3dwX3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJfQog
CiAJdW5sb2NrX3BhZ2UocGFnZSk7CitmYWlsZWRfdG9fbG9jazoKIAlzcGluX3VubG9jayh2bWYt
PnB0bCk7CiBmYWxsYmFjazoKIAlfX3NwbGl0X2h1Z2VfcG1kKHZtYSwgdm1mLT5wbWQsIHZtZi0+
YWRkcmVzcywgZmFsc2UsIE5VTEwpOwo=
--0000000000003201c405d3629bc9--
