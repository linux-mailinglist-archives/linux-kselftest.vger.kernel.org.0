Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BC1A5F28
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgDLPCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 11:02:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34914 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDLPCc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 11:02:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id r26so7695219wmh.0
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=i7Z8LvyenibZTZyXkEsEEE3K8RDOujJ5674sYvNfURpQHNE2oBiWWT7e/r2jmyhWQD
         y1+2fnERImX69QvnWOISWrNrpamrprTbjTLcqfhrku9LoEMEmGG9qEuMsikEqSsaxSqK
         Y79t6ml2mxu6Bg8wZRcptCDJfETVDXs2SZK8GQltSXQNOiaJe/6CdZyheSlXoFomAFYU
         BHejmk7ZGe37MV75QLmNKF23jBsXVadUdm/DzLwRTeJn8gbN5K6kRtSZybzhaMVIOrrG
         kkpACiuBfCAkHXBTZasQv7jicUw7dN29mk5V0RP+E4nBX49iA5hmeuiTzHvVhCaBoAUV
         g05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0yqa+EKJqOMZqIixsYzmlt55IzP82TkpcbHu7uxFT4o=;
        b=HnYcKYo6mIIZeaEY3RdCCstVZtKUqZ/zVHo6Ij8+VvDb8dDvDqbKkEPIccfVzRMV0v
         zP4zBi/27jR6Nbfx6MAN8COUmuTr3MKpGoszrcqJZHdBFVoscQOK3Yv4FT7Dcl+UO6sQ
         dcV2LZlntEevTirMK8yV4ZavNNFHyI54c/ECDWBOkfpbcejF6Ofq7cCPwJzE1gR1y2bG
         lpTfwY/KVDgx9O5rTySqqMl1SQGR1SXRuvJmz3SU2dHPO1PDW45pc8hVcmgKjUdqzZky
         TelFT7TnfJc9JFhcOtWC0n/5rEhkjsChwaftC0wZphG1g5Gm+j5t0xeO/6sLf2Nw+aso
         e17A==
X-Gm-Message-State: AGi0PuY8RiBt0WTaJ5/jOg7oh2s/ulWbW65dZEIfkfyVbQOjBk8ogIQ0
        5n65ujhEuJXHVEyy4Ff1umgLV1Tlz1I=
X-Google-Smtp-Source: APiQypJ5G4BL6g1G/EhYOU8fMFTZs+je8F9lWXNuf0JLZA90eJeTelxDQNlTSUguKI6gLklzRQKBzw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14005777wme.159.1586703750678;
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Received: from ?IPv6:2001:1715:4e3a:130:cca:5c89:8758:a721? ([2001:1715:4e3a:130:cca:5c89:8758:a721])
        by smtp.gmail.com with ESMTPSA id i13sm5808364wro.50.2020.04.12.08.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 08:02:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
Date:   Sun, 12 Apr 2020 17:02:27 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkkon,

> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
> +        except ProtocolError(e):

Should this not be

        except ProtocolError as e:

?

Cheers,
Ezra.

