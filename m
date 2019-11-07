Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C572F39A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKGUji (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 15:39:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39104 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKGUji (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 15:39:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id e17so3227198otk.6
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYuXSkdrHbi6HQVkPYIcJyzI96fCgmbEDSoPSr5PtAU=;
        b=nPXrCLUCJhTEuU5vgEEZJ1aS0zcIQgJmkRVeozdy8exHWSC4KYRbhvwRXmp6SqvHxe
         Lx9yQnA1QBDF/nWtotrnGqV6e3+7I2bU7X9TUpdaYskGKfTqKtAgBF3RDiecDuFXv39t
         uM6S2IDu/epNa5sZLi4T+tODVOUTki70jZPNT0tT7s8vou+srvtj6lN6x9HVs0LLV9wr
         HDExD5R16jO+LpObb8xAbhqr0fh6UEnygWGVd1UGV6vyiRUNbhSdgAAQcjgNPiAOtVnf
         vYomHu/Mz+BpH/FDNCGqG9m0KUgQ7a/SnneurWGIQF2bAWGtD7ND6fU/vOzq/g90EgLC
         aXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYuXSkdrHbi6HQVkPYIcJyzI96fCgmbEDSoPSr5PtAU=;
        b=pdjfov/0RHLyzX+J+kvXS7o4u3eQC6bzfWAHBx6MhrCICoVGnilwaFjPPfjmMSrOtg
         AVfa9OlzeUC0Qplq/cmPzjyZ9yeGRDlVGTQXRarEvqL7MmxIUCVq0m/224oghjgBjiWc
         yQdS7hDW9cRQvXUS1pvsNtwXGkzO/hHHMSUEzRhfBIDZ+Uf9eyPqqnPlZUjLSwnr/TZa
         ytYSUYtiHYzxhLG6MdsCh3qRnj7PwTRsk2LdCKlysOzI77eNr20xMYokWWf0bTtXw3jR
         gWlYoW7nB9JFFtS9bfzIPoaXO+Bw3YyqaPLH5AfzQ0BWbxvhEr8L9baJ+Hb3/VvB8InI
         kLsw==
X-Gm-Message-State: APjAAAXCWJzhmp17CLGZsbZgPRVQeMxIUwMkO3HXZQNSQsvxbzVz997b
        8LbFuwrIfBXzolSKXW/GTh6nEHvPtQ3zNKrFbQxqnA==
X-Google-Smtp-Source: APXvYqwSsiN54Jb7GeTFajAhyV4TNhAtB1IZayinm7Pmx7VZhhFSZvSspRGlSx9JS6J8v3DKHm+Djw1yV2JrVAFWfuU=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr4702206otk.332.1573159175637;
 Thu, 07 Nov 2019 12:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20191101020450.12948-1-ice_yangxiao@163.com> <e343dbf7-323f-c513-50ca-feda4f0ab6ec@163.com>
 <1386a7d3-1114-d0e5-65b0-d81c032ac657@kernel.org>
In-Reply-To: <1386a7d3-1114-d0e5-65b0-d81c032ac657@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 7 Nov 2019 12:39:24 -0800
Message-ID: <CALAqxLU=fwt77mC0CJRgtVAzLhAUHou01J_cDSoc2kx5=ArrGw@mail.gmail.com>
Subject: Re: [PATCH] kselftests/dmabuf-heaps: Fix compiler error in one condition
To:     shuah <shuah@kernel.org>
Cc:     Xiao Yang <ice_yangxiao@163.com>, linux-kselftest@vger.kernel.org,
        philip.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 7, 2019 at 12:37 PM shuah <shuah@kernel.org> wrote:
>
> On 10/31/19 8:25 PM, Xiao Yang wrote:
> > Hi,
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> Do you plan to send another patch? I don't understand
> if this meant you think this patch doesn't fix the
> problem?

I've actually folded in the fix into my patches.

thanks
-john
