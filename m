Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2604B5580
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfIQSll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:41:41 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52505 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfIQSlk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:41:40 -0400
Received: by mail-wm1-f42.google.com with SMTP id x2so4729308wmj.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2019 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5G3rkPk0hBWWfKk0zmlaXS0cG7EqfOE24yF2eINPFNU=;
        b=JLs8PzifFAtc5C7PW3xzSOKiemK0DWdWay8XvfgmgEzA2CJVA1XIrTg3lVbtO/ZUM1
         /NPTbIrzqtQEglsrqwFz+mjo/J1zs9Cz9UE7siGvMAjaNeKEuX0B6byT1Ndr0bGSrMZI
         SU/WL/67/non67PzHiiAeFBgqp8hFpB0As9wtFBcWWfKh6u8gjhaHe7/oL0AGf414DlV
         pkwAf+SFv0oi5niirm/ZTvhgzsOLKjs1qD/xB15IDSTzv7e90zxl+fc413EvMrEzjqGO
         tTRMdf5ikO0WyyBOVPf+FxagSkxqvsf5Z+64ZLHa3WmhHyR29pkWauEG9MvaQNoOahfO
         giNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5G3rkPk0hBWWfKk0zmlaXS0cG7EqfOE24yF2eINPFNU=;
        b=Wsd02EdoNFucDCzirNHth1cCpggRPDGByhOxMETGFEd/61wjQ82MIl7NUN+Io474TN
         8lhkbi1sKrUgWPceQ0t4Sdhnq9zLzmd/xw5jne7giUtonB+VjcENqh1vLtnMaDhZhdzm
         3V4cXvs3z2JZMkCuTBZpXJolUZyzO7aqLSU0KDNkhPS41p6AS4KGQwqdWUpsLejEfv3P
         ToYIVpBYbSrLXr959Gk3FSEqprGrHkDCkxapct5fkO4kQD8nD1QXryg2qulSOTm9t/6n
         RSDYr5KNLEVQasZxrFHVEFaQnROPuOzCyFXM0MTqvvgKDlKIO7/DYIM9skI8hfvwKqAw
         LCbQ==
X-Gm-Message-State: APjAAAVhByFoNpRy0c3fZPa6JdW3sFQ7KNRt4/RonMsNEnQv616EVB1I
        /Yv/2ciX/dBRe7yH/tUBn8seHRNpivlO9Cp8UnrYdA==
X-Google-Smtp-Source: APXvYqz0WtG9bi0mwfu9alHJg9A+90MUZR279MjUFyBWGKxFJzPcXCR4LTGCq5SXQCfELpMSPVCeNNpn7yEhtsowKZE=
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr4486586wma.43.1568745696340;
 Tue, 17 Sep 2019 11:41:36 -0700 (PDT)
MIME-Version: 1.0
From:   David Gow <davidgow@google.com>
Date:   Tue, 17 Sep 2019 11:41:25 -0700
Message-ID: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
Subject: kunit: what do we do with the 'kunit/alpha/master' branch?
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Chiang <davidchiang@google.com>,
        David Siebert <David.Siebert@l3harris.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Pei Huang <peihuang@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sangsu Ha <sangsu.ha@samsung.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000003a5ce0592c4129b"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000003a5ce0592c4129b
Content-Type: text/plain; charset="UTF-8"

TL;DR: We expect KUnit to be accepted upstream into Linus' branch in
the next week or two, and we now need to figure out what we are going
to do with our non-upstream 'kunit/alpha/master' branch.


Hello everyone,

We've put together a rough proposal of what we should do with our
not-upstream branch, known to most people using it as
'kunit/alpha/master'[1], now that KUnit's acceptance into mainline
appears to be imminent (the KUnit MVP patchset is now in linux-next,
and the merge window just opened).

==========
Background
==========

KUnit development is currently split between two versions: the
'kunit/alpha/master'[1] git branch, and the version being submitted to
the upstream Linux kernel. While there are some good reasons to
continue to have two separate versions of KUnit, at present there is
some uncertainty around the difference between these versions, and in
which circumstances each version is useful.

At present, the 'kunit/alpha/master' branch serves a few different
purposes. It is a place for code not-yet-ready for upstream -- such as
the mocking framework -- while being developed, while also acting as a
stable version for customers who do not wish to follow along with the
changes made during the upstreaming process. Adding to the confusion,
the name 'kunit/alpha/master' refers to an early (alpha) version of
KUnit, and the version of KUnit being upstreamed has now diverged
significantly from this version, requiring significant differences in
documentation, and requiring a number of changes to tests when porting
from one version to the other. Finally, it is not clear how the
'kunit/alpha/master' version should evolve as features it contains are
upstreamed.

On the other hand, the version being upstreamed has its own
complications. It contains significantly fewer features (as features
such as the mocking frameworks will be upstreamed individually), and
so is less useful for the average customer. Until each feature is
upstreamed, it is iterated on rapidly to address comments from the
kernel community, so in-progress features are not stable enough to
reasonably build on. Finally, it exists only as a set of patches on
mailing lists, rather than as a maintained git repository (due to the
fact that the patches themselves are changing rapidly), making it
difficult for early adopters to incorporate into their own trees.

Whilst we believe there to be enough (at times conflicting) goals
above to justify having multiple versions of KUnit, we want to ensure
that they are meeting their goals, and that we have a process to
ensure that code finds its way into the correct version, that we can
deprecate and remove failed experiments or superseded versions, and
that we can keep pace with upstream kernel releases.

============
The Proposal
============

We propose having two tracks of development: the upstream kernel
(comprising both code that has been upstreamed, and code which is in
the process of being upstreamed -- i.e. is being reviewed on the
mailing lists), and an 'experimental' branch, which contains features
which are yet to be submitted upstream.

Periodically, the 'experimental' branch will be replaced with a new
'experimental' branch based on the latest upstream version. This will
allow us to focus on code based on upstream versions by deprecating
earlier, experimental versions of features. The older experimental
branch will stay around, but receive no new features or support:
customers will need to eventually migrate to either the upstream
kernel (if all of the features they require have been upstreamed), or
to the latest 'experimental' branch (if they still require
non-upstreamed features).

Where practical, 'experimental' branches will try to provide a stable
interface (and/or compatibility layers/shims) such that users can
write tests against an experimental version and expect our changes to
break them infrequently. We don't intend to make any solid guarantee,
however: so users will need to be able to deal with some breakage.

We expect most changes to KUnit to be submitted directly upstream, and
reserve the 'experimental' branch for features where:
a) the design is yet to be proven by early adopters, and is likely to change;
b) the feature is large enough that having a solid staging environment
in which several developers can work is necessary; and/or
c) it depends on existing features only available in the 'experimental' branch.

An example of features suited to the 'experimental' branch are the
mocking systems[2].

=====================
Lifetime of a feature
=====================

A new feature (that for one of the above reasons may require some
experimentation before being sent upstream) would typically be
developed as follows:

1. An initial version of the feature is developed against the latest
'experimental' branch.
2. The feature is tested by users of the 'experimental' branch.
3. It is revised as needed within the 'experimental' branch. If
breaking changes are required, and supporting some form of
compatibility layer is practical, such a layer is implemented to avoid
breaking existing 'experimental' customers.
4. Once the feature is deemed ready, it is submitted to the mailing
lists for the upstream kernel. Any compatibility layers for earlier
experimental version are removed -- this is a 'clean' version of the
change.
5. Development of the change continues on the kernel mailing lists:
any particularly important changes or bugfixes are ported to the
'experimental' branch if feasible, but complete convergence is not
expected at this stage.
6. When the feature is accepted upstream, a new 'experimental' branch
is created based on the new upstream kernel. Development on the old
'experimental' branch ceases.
7. The upstream version of the feature has now superseded the
experimental version. All future development is done based on the
upstream version, either in the new 'experimental' branch, or directly
against the upstream kernel.
8. Any customers still using the experimental version of the feature
will need to update their code to work with the upstream version in
order to update to the new (supported) 'experimental' branch, or to
the upstream kernel.

===========================
What does this mean for me?
===========================

...as a user?
-------------

If you're using the upstream version of KUnit, nothing! Features will
continue to be pushed upstream when they're ready.

If you're using the 'kunit/alpha/master' branch, then you'll need to
switch to the new 'experimental-<version>' branches. Every so often,
we'll create a new 'experimental-<version>' branch, and you'll need to
rebase your code on top of that to keep receiving updated features and
bugfixes. While we intend to make this as painless as possible, there
may be breaking changes which require you to rework some of your
tests.

Once a feature exists in the upstream kernel, the version of that
feature in the 'experimental' branches should stabilise somewhat.

...as a KUnit developer?
------------------------

For most changes/bugfixes which apply cleanly to the upstream version,
you should directly submit these upstream as before. If it is feasible
and useful to backport them to the latest 'experimental' branch (e.g.,
they are bugfixes to code that the experimental branch already has),
please do so.

For more major features (or anything which depends on
yet-to-be-upstreamed code), you should develop them in the latest
'experimental' branch. For the most part, you can treat this the same
way as the old 'kunit/alpha/master' branch, but note that changes will
need to be rebased on top of a newer experimental branch periodically.
It may make sense to use this as an opportunity to tidy the code up
somewhat: by removing compatibility code for deprecated features, or
to merge 'fixup' commits. Once the code has been upstreamed, the next
rebase of the 'experimental' branch should only use the upstream
version: there should not be a separate 'experimental' version of
upstream code save for the development of a new 'experimental' feature
or bugfix.

For more details, see the 'Lifetime of a feature' section above.

=============
In Conclusion
=============

We'll continue to be working with upstream as before, but we intend to
rename and more explicitly specify the purpose of the
'kunit/alpha/master' branch as above. This will require a bit more
work from people using and developing against this 'experimental'
branch, but allows us to continue to use it for features such as the
mocking framework while limiting its divergence from upstream.

Do let us know if this sounds reasonable to you, if it will affect
your use case, or if you have any questions.

Cheers,
-- David & Brendan


[1] https://kunit.googlesource.com/linux/+/refs/heads/kunit/alpha/master
[2] https://kunit.googlesource.com/linux/+/kunit/alpha/master/Documentation/test/usage.rst#187

--00000000000003a5ce0592c4129b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6wYJKoZIhvcNAQcCoIIS3DCCEtgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBRMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
CCsGAQUFBzAChjRodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2h2c21pbWVj
YTEuY3J0MB0GA1UdDgQWBBSZyvyRreTRp+gUyf6vW7p8tyBSITAfBgNVHSMEGDAWgBTLOBKwx5nA
eJKMsyGV5vQmYsDgPzBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzA7BgNVHR8ENDAyMDCgLqAshipodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzaHZzbWltZWNhMS5jcmwwDgYDVR0PAQH/BAQDAgWgMB0G
A1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDANBgkqhkiG9w0BAQsFAAOCAQEACwT27gzXkl6b
7+EfswyCAA1ILEwMiRx2hozR/i7o6qlwQW7aLeaUdNH0FfdGzmDm1/E4z2/F8OUAftiVa3Njd74k
vmE0XVZa8nojKjsQ97cHmZWO21L92O7ASV5OXSpmbebF2fvyFaX8q31upLngnrv5BzEm1ayGGj1I
vFK3Sz/VGxNVen5WDJZ0mb22I2FOdK9nPP5i/thaLXIHUxlsMj0TL+d6F7UUwR/kjq23qaW1rqWf
zai0PSzQ9GJu060idigAOkoMlSkWphhvLMjdeQ/BOtQWGbQmjXeAaTCicoGh/PInMrvWsqeB3UN7
tS993eH1GtcIzD4HO7q6+RjXFTGCAl4wggJaAgEBMFwwTDELMAkGA1UEBhMCQkUxGTAXBgNVBAoT
EEdsb2JhbFNpZ24gbnYtc2ExIjAgBgNVBAMTGUdsb2JhbFNpZ24gSFYgUy9NSU1FIENBIDECDDj8
hcuhQo0nUVK3VTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgjRCF1pITrSiS9OwN
q8EneLlveWPAPdkOlYsJPlXFYj8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTkwOTE3MTg0MTM3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACMofrrNe30fOMSU2uggIbUMfkyZ2V2XzfHq
fZCLi37FGXUXF9Zxqn4eY/keGxLycexOD7pPpNxj3xXMVwRH/s6unt/taUHtkFInLPj8g56XXAnr
zWtGObnnIb/LhBlxbLa5aVq8JUpIbiZ8iKSrJpVeKvWGbVfdUk3LbTC5GeqjTQM6kt3PBhaZchjN
GD/3qeLXozusHVtbJf2TY0VloTAPlqwbH2Mcz8BqSkJMyE+v9UAd3ZAKDT0rYTBFhc4wChCXJ8a7
VKZZP7SPTFZWjHx+GWqbvYjsaVJhdfNL2K3jvs+tLEI7CXMH4CFwhIJq9Ac+jYGtGczV+aP/vsaR
6M8=
--00000000000003a5ce0592c4129b--
