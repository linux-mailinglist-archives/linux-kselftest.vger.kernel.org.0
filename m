Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E592EA3B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJ3S7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 14:59:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41547 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfJ3S7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 14:59:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so2074169pgr.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lydW9atQW2RqhX2w9FQSYN22+fl/dNiMF69085WMHtM=;
        b=ngQ4YsXEu3hNnNn3MSw8hh8vZ5syLFrqYQcNZ6AnbPi7LDobSUUnL9sWE4OlkQghF8
         yYdjVJJ6Detmtfk4AntUsuUYUFDP9MTXrG+RdAPrgHZXXDqgzoakrJw1DnjVbg19fYzo
         z/kw/vK6g7IcWfCMXQ03sOl7rkKhj5iGdxf9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lydW9atQW2RqhX2w9FQSYN22+fl/dNiMF69085WMHtM=;
        b=fkWLy/fAhy2iR3Cathv2zNwG/fZERrnppxdK7wthSYGSXZZkqKCOUvrYhvEUTHwHo5
         mY20mhVrX/97xQXPXYrJdoPo/ERgMg0Y6zAF2TJTynrEcIG5ELsGOQQrqB3grwgiGEoo
         YlwPhPy2A2SN1FHf1TVse46NPAC3jZs+lgsXIjvALuqL8MVSCNyt57fhoroZ2h07yGX6
         vXNO5XPNygEU1uU1ItDCQsj43usnbipyRLXNhSbQlLvRFe5nZ77k6CEOKLRaJ9bAHk3y
         rDSIrGJ0tMlZgQZpAC8HnwOgE7imAahgJjKPl/ceVZadFmpwPW0fUw1kQiSyYJrDpHIM
         E7Ew==
X-Gm-Message-State: APjAAAW2IGzmJaN4G8F0SawcFYzkI8nhYVMHAByoERGL/AzfzBaaD3XE
        eUUZWQzIo1+kAvQbRhvdxZpiJA==
X-Google-Smtp-Source: APXvYqyi6mqapjcTlpY6OS6+c0zNuBWc9Fp5Tnew7VwPk6+TzOYM8OkMJvisUME8Culvm6LoCo8NTg==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr932975pfd.168.1572461942183;
        Wed, 30 Oct 2019 11:59:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm3936091pjc.23.2019.10.30.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:59:01 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:59:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com, alan.maguire@oracle.com,
        davidgow@google.com, Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910301157.58D0CE4D3@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 05:33:56PM -0700, Iurii Zaikin wrote:
> On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> 
> > +config SECURITY_APPARMOR_TEST
> > +       bool "Build KUnit tests for policy_unpack.c"
> > +       default n

New options already already default n, this can be left off.

> > +       depends on KUNIT && SECURITY_APPARMOR
> > +       help
> >
> select SECURITY_APPARMOR ?

"select" doesn't enforce dependencies, so just a "depends ..." is
correct.

> > +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> > +       KUNIT_EXPECT_TRUE(test,
> > +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
> otherwise there could be a buffer overflow in memcmp. All tests that
> follow such pattern

Agreed.

> are suspect. Also, not sure about your stylistic preference for
> KUNIT_EXPECT_TRUE(test,
>                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> vs
> KUNIT_EXPECT_EQ(test,
>                0,
>                memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));

I like == 0.

-- 
Kees Cook
